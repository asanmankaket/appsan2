import 'package:creative/views/booking/backup.dart';
import 'package:flutter/material.dart';
import 'package:creative/views/bcome/_register.dart';
import 'package:creative/views/booking/booking.dart';

import '../views/booking/mainpage.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/PageOne': (context) => const PageOne(),
  '/MainPage': (context) => const MainPage(),
  '/book': (context) => const Booking(),
  '/Backup': (context) => const BackUp(),
};
