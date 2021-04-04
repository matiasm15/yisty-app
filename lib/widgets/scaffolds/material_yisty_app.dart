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
            secondaryHeaderColor: Colors.white,
            textTheme: const TextTheme(
              bodyText2: TextStyle(
                color: Color.fromRGBO(13, 12, 34, 1)
              )
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) => Colors.green
                ),
              ),
            )
        ),
        initialRoute: '/home',
        routes: appRoutes
    );
  }
}