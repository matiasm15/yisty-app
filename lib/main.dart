import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yisty_app/data/stores/ui_singleton.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/home/home_page.dart';
import 'package:yisty_app/screens/login/index.dart';
import 'package:yisty_app/widgets/design/loading_page.dart';

import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(YistyApp()));
}

class YistyApp extends StatelessWidget {
  final Future<User> _future = UiSingleton().uiStore().loadUser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yisty',
        theme: ThemeData(
          backgroundColor: Colors.yellow,
          buttonColor: Colors.green,
          errorColor: Colors.red,
          primaryColor: Colors.green,
        ),
        home: FutureBuilder<User>(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                //initialRoute = '/login';
                return const LoginPage();
              } else {
                return const HomePage();
                //initialRoute = '/home';
              }

              //Navigator.pushReplacementNamed(context, initialRoute);
            }

            return const LoadingPage();
          },
        ),
        routes: appRoutes);
  }
}
