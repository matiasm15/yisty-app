import 'package:flutter/material.dart';
import 'package:yisty_app/screens/configuration/index.dart';

import 'package:yisty_app/screens/history/history_page.dart';
import 'package:yisty_app/screens/home/home_page.dart';
import 'package:yisty_app/screens/login/login_page.dart';
import 'package:yisty_app/screens/registration/registration_page.dart';
import 'package:yisty_app/screens/scanner/scanner_page.dart';


final Map<String, WidgetBuilder> appRoutes = <String, WidgetBuilder>{
  '/login': (BuildContext context) => const LoginPage(),
  '/history': (BuildContext context) => const HistoryPage(),
  '/home': (BuildContext context) => const HomePage(),
  '/scanner': (BuildContext context) => const ScannerPage(),
  '/registration': (BuildContext context) => const RegistrationPage(),
  '/configuration': (BuildContext context) => const ConfigurationPage(),
};
