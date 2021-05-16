import 'dart:async';

import 'package:flutter_config/flutter_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

class ConfigurationPrivacyPolicy extends StatefulWidget {
  const ConfigurationPrivacyPolicy({Key key}) : super(key: key);

  @override
  _ConfigurationPrivacyPolicyState createState() => _ConfigurationPrivacyPolicyState();
  
}

class _ConfigurationPrivacyPolicyState extends State<ConfigurationPrivacyPolicy> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  String get title => 'Términos y condiciones';
  String get url => FlutterConfig.get('YISTY_API_URL').toString() + '/tos/';

  Widget _buildPrivacyAndPolicy() {
    return Container(
      height: 3200,
      width: MediaQuery.of(context).size.width,
      child: WebView(
        initialUrl: url,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      builder: (_) => _buildPrivacyAndPolicy(),
      title: Text(title),
    );
  }
}