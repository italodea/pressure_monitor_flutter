// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pressure_monitor_flutter/pages/Home/home_page.dart';
import 'package:pressure_monitor_flutter/pages/Login/login_page.dart';
import 'package:pressure_monitor_flutter/pages/PersonalPage/personal_page.dart';
import 'package:pressure_monitor_flutter/pages/PressureHistoryPage/pressure_history_page.dart';
import 'package:pressure_monitor_flutter/pages/PressurePage/pressure_page.dart';
import 'package:pressure_monitor_flutter/pages/Register/register_page.dart';

class AppRoute {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PERSONAL = '/personal';
  static const PRESSURE = '/pressure';
  static const PRESSURE_HISTORY = '/pressure_history';

  static Map<String, WidgetBuilder> routes = {
    HOME: (context) => const HomePage(),
    LOGIN: (context) => const LoginPage(),
    REGISTER: (context) => const RegisterPage(),
    PERSONAL: (context) => const PersonalPage(),
    PRESSURE: (context) => const PressurePage(),
    PRESSURE_HISTORY: (context) => const PressureHistoryPage(),
  };
}
