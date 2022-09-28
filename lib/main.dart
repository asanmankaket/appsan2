import 'package:flutter/material.dart';
import 'package:creative/route/route.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'views/bcome/_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}
