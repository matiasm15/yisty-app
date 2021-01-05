import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor)),
              width: 60,
              height: 60,
            )
          ],
        )));
  }
}
