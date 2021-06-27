
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicy createState() => _PrivacyPolicy();

}

class _PrivacyPolicy extends State<PrivacyPolicy> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  String get url => FlutterConfig.get('YISTY_API_URL').toString() + '/tos/';


  Widget _buildPrivacyPolicy() {
    final EdgeInsets padding = InheritedProvider.of(context).uiStore.screenPadding;

    return Container(
      height: MediaQuery.of(context).size.height - padding?.top - padding?.bottom - kToolbarHeight,
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
    return BasicScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop()
        ),
      ),
      body: _buildPrivacyPolicy(),
    );
  }


}