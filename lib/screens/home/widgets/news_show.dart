import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';
import 'package:share/share.dart';


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
    final EdgeInsets padding = InheritedProvider.of(context).uiStore.screenPadding;

    return BasicScaffold(
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
            IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 16),
              icon: const Icon(Icons.share),
              onPressed: () => Share.share('Compartir noticia: ${widget.postUrl}')
          )
        ],
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - padding?.top - padding?.bottom - kToolbarHeight,
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