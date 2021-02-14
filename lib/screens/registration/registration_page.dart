import 'package:flutter/material.dart';
import 'package:yisty_app/screens/registration/widgets/registration_form.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';

@immutable
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      backgroundColor: Colors.yellow,
      body: Column(children: <Widget>[
        Container(
          child: Image.asset(
            'assets/logo.png',
            height: 200,
            width: 200,
          ),
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: RegistrationForm())
      ]),
    );
  }
}