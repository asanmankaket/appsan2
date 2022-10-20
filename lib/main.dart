import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:creative/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'views/login/login.dart';
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
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: 'assets/images/logo.png',
        splashIconSize: double.infinity,
        nextScreen: const MyHomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color.fromARGB(255, 45, 134, 156),
      ),
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}
