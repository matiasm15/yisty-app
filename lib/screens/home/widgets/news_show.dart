import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class NewsShow extends StatefulWidget {

  NewsShow({@required this.postUrl});
  String postUrl;

  @override
  _NewsShowState createState() => _NewsShowState();
}

class _NewsShowState extends State<NewsShow> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget> [
            const Text(
              'Yisty',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const Text(
              'News',
              style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: <Widget> [
          Opacity(
              opacity: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.share)
              ))
        ],
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}