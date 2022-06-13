import 'dart:convert';

import 'package:creative/configs/config.dart';
import 'package:creative/views/bcome/_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:creative/views/booking/mainpage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future checkLogin(String username, String password, context) async {
  EasyLoading.show(status: 'loading...');

  Uri url = Uri.parse('http://206.189.92.71:3200/api/mentor/login');
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
      prefs.setInt('idm', data['idm']);
      headers?['Authorization'] = "bearer ${data['token']}";
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainPage()),
          (Route<dynamic> route) => false);
    } else {
      EasyLoading.showError('Failed with Error');
    }
  });
}

Future checkRegister(String username, String password, String name,
    String surname, String picdate, context) async {
  EasyLoading.show(status: 'loading...');

  Uri url = Uri.parse('http://165.22.63.114:3200/api/customer');
  http
      .post(
    url,
    headers: headers,
    body: jsonEncode({
      "username": username,
      "password": password,
      "fname": name,
      "lname": surname,
    }),
  )
      .then((req) async {
    if (req.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(req.body);
      prefs.setString('token', data['token']);

      headers?['Authorization'] = "bearer ${data['token']}";
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PageOne()),
          (Route<dynamic> route) => false);
      prefs.setInt('idm', data['id']);
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
      'http://206.189.92.71:3200/api/booking/cust/$idPage/$idUser'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
//รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
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

Future<dynamic> confirmBook(dynamic idb, int statusbook, context) async {
  Uri url = Uri.parse(
      'http://206.189.92.71:3200/api/booking/$idb'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  return await http
      .put(
    url,
    headers: headers,
    body: jsonEncode({"bstatus": statusbook}),
  )
      .then((req) async {
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
  Uri url = Uri.parse('http://206.189.92.71:3200/api/mentor/$idUser');
  // Uri url = Uri.parse('http://192.168.1.9:3200/api/customer/$idUser');
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
