import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/services/app_service.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/material_yisty_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]
  ).then((_) =>
    SentryFlutter.init(
      (SentryFlutterOptions options) {
        options.dsn = FlutterConfig.get('SENTRY_URL').toString();
      },
      appRunner: () => runApp(YistyApp()),
    )
  );
}

class YistyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InheritedProvider(
        uiStore: UiStore(),
        services: AppService(),
        child: const MaterialYistyApp()
    );
  }
}
