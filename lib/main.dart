import 'package:flutter/material.dart';
import 'package:creative/route/route.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'views/bcome/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
