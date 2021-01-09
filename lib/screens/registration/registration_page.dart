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
          child: Image.asset('assets/logo.png'),
          padding: const EdgeInsets.only(left: 10,  right: 10, top: 15),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: RegistrationForm())
      ]),
    );
  }
}