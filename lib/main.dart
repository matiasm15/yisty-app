import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/home/home_page.dart';
import 'package:yisty_app/screens/login/index.dart';
import 'package:yisty_app/services/app_service.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/design/loading_page.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(YistyApp()));
}

class YistyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InheritedProvider(
        uiStore: UiStore(),
        services: AppService(),
        child: Builder(builder: (BuildContext innerContext) {
          final Future<User> _future = InheritedProvider.of(innerContext).uiStore.loadUser();

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
        }));
  }
}
