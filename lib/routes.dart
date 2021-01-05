import 'package:flutter/material.dart';

import 'screens/home/index.dart';
import 'screens/login/index.dart';
import 'screens/scanner/index.dart';

final Map<String, WidgetBuilder> appRoutes = <String, WidgetBuilder>{
  '/login': (BuildContext context) => const LoginPage(),
  '/home': (BuildContext context) => const HomePage(),
  '/scanner': (BuildContext context) => const ScannerPage(),
};
