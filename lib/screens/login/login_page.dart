import 'package:flutter/material.dart';
import 'package:yisty_app/screens/login/widgets/login_form.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';

@immutable
class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      backgroundColor: Colors.yellow,
      body: Column(children: <Widget>[
        Container(
          child: Image.asset('assets/logo_full.png'),
          padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: LoginForm())
      ]),
    );
  }
}
