import 'dart:convert';
import 'dart:io';
import 'package:creative/configs/config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/battom_main.dart';
import 'package:path/path.dart';

String? apiURL = dotenv.get("API_HOST", fallback: "");

Future sendusername(String username) async {
  Uri url = Uri.parse(apiURL! + '/mentor/checkuser/$username');
  return await http
      .get(
    url,
    headers: headers,
  )
      .then((req) async {
    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      return data;
    } else {
      return null;
    }
  });
}

Future checkLogin(String username, String password, context) async {
  EasyLoading.show(status: 'loading...');
  bool result = false;
  result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    Uri url = Uri.parse(apiURL! + '/mentor/login');
    http
        .post(
      url,
      headers: headers,
      body: jsonEncode({"username": username, "password": password}),
    )
        .then((req) async {
      if (req.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        var data = jsonDecode(req.body);
        prefs.setString('token', data['token']);
        prefs.setInt('idm', data['men_id']);
        headers?['Authorization'] = "bearer ${data['token']}";
        EasyLoading.showSuccess('Great Success!');
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Page0', (Route<dynamic> route) => false);
      } else {
        EasyLoading.showError('Failed with Error');
      }
    });
  } else {
    EasyLoading.showError('ไม่มีการเชื่อมต่อกับอินเทอร์เน็ต');
  }
}

Future checkRegister(title, username, password, name, surname, birtday, phone,
    citizenid, type, rate, _image, datenow, context) async {
  EasyLoading.show(status: 'loading...');
  bool result = false;
  result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    var stream = http.ByteStream(_image.openRead());
    var length = await _image.length();
    Uri url = Uri.parse(apiURL! + '/mentor');
    http.MultipartRequest request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers!);
    request.files.add(
      // replace file with your field name exampe: image
      http.MultipartFile('photo', stream, length,
          contentType: MediaType('image', 'jpeg'),
          filename: basename(_image.path)),
    );
    request.fields.addAll({
      "title": title,
      "username": username,
      "password": password,
      "fname": name,
      "lname": surname,
      "phone": phone,
      "idcard": citizenid,
      "type": type,
      "rate": rate,
      "birtday": birtday,
      "dateregis": datenow
    });
    var req = await http.Response.fromStream(await request.send());
    if (req.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(req.body);
      prefs.setString('token', data['token']);
      prefs.setInt('idm', data['id']);
      headers?['Authorization'] = "bearer ${data['token']}";
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page4', (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  } else {
    EasyLoading.showError('ไม่มีการเชื่อมต่อกับอินเทอร์เน็ต');
  }
}

Future<dynamic> getdata(int idPage) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! +
      '/booking/cust/"$idPage"/$idUser'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
//รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  return await http
      .get(
    url,
  )
      .then(
    (req) {
      if (req.statusCode == 200) {
        var data = jsonDecode(req.body);
        return data;
      } else {
        return null;
      }
    },
  );
}

Future<dynamic> getAvg() async {
  Uri url = Uri.parse(apiURL! + '/mentor/findAvg');
  return await http
      .get(
    url,
  )
      .then(
    (req) {
      if (req.statusCode == 200) {
        var data = jsonDecode(req.body);
        return data;
      } else {
        return null;
      }
    },
  );
}

Future getdateWork(startdate, enddate) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idMentor = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/booking/fd/$startdate/$enddate/$idMentor');
  return await http
      .get(
    url,
    headers: headers,
  )
      .then((req) async {
    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      return data;
    } else {
      return null;
    }
  });
}

Future<dynamic> confirmBook(
    dynamic idb, int statusbook, textbook, context) async {
  EasyLoading.showProgress(0.3, status: 'กำลังประมวลผล...');
  Uri url = Uri.parse(apiURL! +
      '/booking/$idb'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  return await http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"bstatus": statusbook, "content": textbook}),
  )
      .then((req) {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('สำเร็จ!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page0', (Route<dynamic> route) => false);
    } else {
      return null;
    }
  });
}

Future<dynamic> inputcomment() async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idMentor = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/review/$idMentor');
  //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  return await http
      .get(
    url,
  )
      .then((req) async {
    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      return data;
    } else {
      return null;
    }
  });
}

Future<dynamic> getProfile() async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/mentor/$idUser');
  return await http
      .get(
    url,
    headers: headers,
  )
      .then((req) {
    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      return data;
    } else {
      return null;
    }
  });
}

Future sendDataProfile1(oldpassword, password, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/mentor/p1/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"oldpassword": oldpassword, "password": password}),
  )
      .then((req) {
    if (req.statusCode == 200) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const BottomBarMain(index: 3)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future<dynamic> sendDataProfile2(
    String title, String name, String surname, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! +
      '/mentor/p2/$idUser'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  return await http
      .put(
    url,
    headers: headers,
    body: jsonEncode({
      "title": title,
      "fname": name,
      "lname": surname,
    }),
  )
      .then((req) {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('สำเร็จ');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page4', (Route<dynamic> route) => false);
    } else {
      return null;
    }
  });
}

Future sendDataProfile3(File _image, context) async {
  EasyLoading.show(status: 'loading...');
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  var stream = http.ByteStream(_image.openRead());
  Uri url = Uri.parse(apiURL! + '/mentor/p3/$idUser');
  var length = await _image.length();
  http.MultipartRequest request = http.MultipartRequest('PUT', url)
    ..headers.addAll(headers!)
    ..files.add(
      // replace file with your field name exampe: image
      http.MultipartFile('photo', stream, length,
          contentType: MediaType('image', 'jpeg'),
          filename: basename(_image.path)),
    );

  var respons = await http.Response.fromStream(await request.send());
  if (respons.statusCode == 204) {
    EasyLoading.showSuccess('Great Success!');
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Page4', (Route<dynamic> route) => false);
  } else {
    EasyLoading.showError('Failed with Error');
  }
}

Future sendDataProfile4(phone, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/mentor/p4/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"phone": phone}),
  )
      .then((req) {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page4', (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfile5(tambons, amphures, provinces, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/mentor/p5/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({
      "tambons": tambons,
      "amphures": amphures,
      "provinces": provinces,
    }),
  )
      .then((req) {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page4', (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfile6(birtday, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/mentor/p6/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"birtday": birtday}),
  )
      .then((req) async {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page4', (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfile7(mentype, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/mentor/p7/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"mentype": mentype}),
  )
      .then((req) async {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page4', (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfileWorkRate(rate, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/mentor/workRate/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"rate": rate}),
  )
      .then((req) async {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page0', (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future<dynamic> resendRegis(now, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(apiURL! + '/manager/men/$idUser');
  http
      .put(url,
          headers: headers,
          body: jsonEncode({
            "status": "0",
            "date": now,
          }))
      .then((req) {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Page1', (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}
