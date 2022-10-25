import 'package:creative/views/battom_main.dart';
import 'package:flutter/material.dart';
import 'package:creative/views/login/register.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/PageRegister': (context) => const RegisterPage(),
  '/Page0': (context) => const BottomBarMain(index: 0),
  '/Page1': (context) => const BottomBarMain(index: 1),
  '/Page2': (context) => const BottomBarMain(index: 2),
  '/Page3': (context) => const BottomBarMain(index: 3),
  '/Page4': (context) => const BottomBarMain(index: 4)
};
