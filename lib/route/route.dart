import 'package:flutter/material.dart';
import 'package:creative/views/bcome/_register.dart';
import 'package:creative/views/booking/booking.dart';
import 'package:creative/views/Map.dart';

import '../views/booking/mainpage.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/PageOne': (context) => const PageOne(),
  '/MainPage': (context) => const MainPage(),
  '/Map': (context) => GoogleMaps(),
  '/book': (context) => const Booking(),
};
