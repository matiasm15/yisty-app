import 'package:flutter/material.dart';

import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/login/login_page.dart';
import 'package:yisty_app/widgets/design/loading_page.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key key, this.builder}) : super(key: key);

  final Widget Function(User) builder;

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  Future<User> future;

  @override
  void didChangeDependencies() {
    future = InheritedProvider.of(context).loadUser();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const LoginPage();
          } else {
            return widget.builder(snapshot.data);
          }
        }

        return const LoadingPage();
      }
    );
  }
}