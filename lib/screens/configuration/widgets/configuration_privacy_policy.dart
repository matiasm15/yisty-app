import 'dart:async';

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
  String get url => 'https://www.privacypolicies.com/live/6ecb0502-a20b-4821-ac64-e08f166783e9';

  Widget _buildPrivacyAndPolicy() {
    return Container(
      height: 10800,
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