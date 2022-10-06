import 'dart:convert';
import 'dart:io';
import 'package:creative/configs/config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/battom_main.dart';
import 'package:path/path.dart';

Future checkLogin(String username, String password, context) async {
  EasyLoading.show(status: 'loading...');

  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/login');
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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 0)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future checkRegister(
    String title,
    String username,
    String password,
    String name,
    String surname,
    String birtday,
    String phone,
    String citizenid,
    String type,
    String rate,
    context) async {
  EasyLoading.show(status: 'loading...');

  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor');

  http
      .post(
    url,
    headers: headers,
    body: jsonEncode({
      "title": title,
      "username": username,
      "password": password,
      "fname": name,
      "lname": surname,
      "phone": phone,
      "idcard": citizenid,
      "type": type,
      "rate": rate,
      "birtday": birtday
    }),
  )
      .then((req) async {
    if (req.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(req.body);
      prefs.setString('token', data['token']);
      prefs.setInt('idm', data['id']);
      headers?['Authorization'] = "bearer ${data['token']}";
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 0)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future<dynamic> getdata(int idPage) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse(
      'http://206.189.145.138:3200/api/booking/cust/"$idPage"/$idUser'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
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
  Uri url = Uri.parse(
      'http://206.189.145.138:3200/api/mentor/findAvg'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
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

Future<dynamic> confirmBook(dynamic idb, int statusbook, context) async {
  Uri url = Uri.parse(
      'http://206.189.145.138:3200/api/booking/$idb'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  return await http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"bstatus": statusbook}),
  )
      .then((req) {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('สำเร็จ');
    } else {
      return null;
    }
  });
}

Future<dynamic> getProfile() async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/$idUser');
  // Uri url = Uri.parse('http://192.168.1.9:3200/api/customer/$idUser');
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
  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/p1/$idUser');
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
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 3)),
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
  Uri url = Uri.parse(
      'http://206.189.145.138:3200/api/mentor/p2/$idUser'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 3)),
          (Route<dynamic> route) => false);
    } else {
      return null;
    }
  });
}

Future sendDataProfile3(File _image, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  var stream = http.ByteStream(_image.openRead());
  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/p3/$idUser');
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
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomBarMain(index: 3)),
        (Route<dynamic> route) => false);
  } else {
    EasyLoading.showError('Failed with Error');
  }
}

Future sendDataProfile4(phone, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/p4/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"phone": phone}),
  )
      .then((req) {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 3)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfile5(tambons, amphures, provinces, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/p5/$idUser');
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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 3)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfile6(birtday, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/p6/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"birtday": birtday}),
  )
      .then((req) async {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 3)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfile7(mentype, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url = Uri.parse('http://206.189.145.138:3200/api/mentor/p7/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"mentype": mentype}),
  )
      .then((req) async {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 3)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future sendDataProfileWorkRate(rate, context) async {
  final prefs =
      await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
  int? idUser = prefs.getInt('idm');
  Uri url =
      Uri.parse('http://206.189.145.138:3200/api/mentor/workRate/$idUser');
  http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"rate": rate}),
  )
      .then((req) async {
    if (req.statusCode == 204) {
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarMain(index: 0)),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}
