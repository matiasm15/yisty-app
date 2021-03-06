import 'package:flutter/material.dart';

import 'package:yisty_app/routes.dart';

class MaterialYistyApp extends StatelessWidget {
  const MaterialYistyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yisty',
        theme: ThemeData(
            backgroundColor: Colors.yellow,
            buttonColor: Colors.green,
            errorColor: Colors.red,
            primaryColor: Colors.green,
            secondaryHeaderColor: Colors.white
        ),
        initialRoute: '/home',
        routes: appRoutes
    );
  }
}