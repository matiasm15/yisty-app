import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_type.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/design/loading_button.dart';

@immutable
class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email = '';
  String password = '';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _emailChanged(String value) {
    setState(() {
      email = value;
    });
  }

  void _passwordChanged(String value) {
    setState(() {
      password = value;
    });
  }

  void _focusChanged(bool hasFocus) {
    InheritedProvider.of(context).uiStore.removeAlert();

    if (!hasFocus) {
      _formKey.currentState.validate();
    }
  }

  void _formSubmitted(RoundedLoadingButtonController controller) {
    FocusScope.of(context).unfocus();

    final InheritedProvider provider = InheritedProvider.of(context);
    final UiStore uiStore = provider.uiStore;
    uiStore.removeAlert();

    // Validate returns true if the form is valid, otherwise false.
    if (_formKey.currentState.validate()) {
      provider.services.users.authenticate(
          email, password
      ).then(
        (User user) async {
          if (user.active) {
            await provider.loginUser(user);

            Navigator.pushReplacementNamed(context, '/home');
          } else {
            uiStore.setAlert(
              message: 'Tu usuario aun no fue activado. Podés hacerlo desde el email que te mandamos a tu casilla.',
              type: AlertType.ERROR
            );
          }
        }
      ).catchError(
        (Object _) => uiStore.setAlert(
          message: 'El email o la contraseña son inválidas.',
          type: AlertType.ERROR
        ),
        test: (Object e) => e is UnauthorisedException
      ).whenComplete(
              () => controller.reset()
      );
    } else {
      controller.reset();
    }
  }

  void _formRegistration() {
    Navigator.of(context).pushNamed('/registration');
  }

  void _formRecovery() {
    Navigator.of(context).pushNamed('/recovery');
  }

  String _emailValidator(String value) {
    if (value.isEmpty) {
      return 'El email no puede ser vacío';
    }

    if (!EmailValidator.validate(value)) {
      return 'El email es inválido';
    }

    if(value.length < 4 || value.length > 128) {
      return 'El email tiene una longitud mínina de 4 y máxima 128';
    }

    return null;
  }

  String _passwordValidator(String value) {
    if (value.isEmpty) {
      return 'La contraseña no puede ser vacía';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Focus(
                  child: TextFormField(
                    onChanged: _emailChanged,
                    validator: _emailValidator,
                    decoration: const InputDecoration(hintText: 'Email', icon: Icon(Icons.alternate_email)),
                  ),
                  onFocusChange: _focusChanged,
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Focus(
                  child: TextFormField(
                    onChanged: _passwordChanged,
                    validator: _passwordValidator,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                      icon: Icon(Icons.lock_outlined),
                    ),
                  ),
                  onFocusChange: _focusChanged,
                ))
          ],
        ),
        Container(
            width: double.infinity,
            height: 40,
            child: LoadingButton(
              text: 'Iniciar sesión',
              onPressed: _formSubmitted,
            )),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 40,
          child: TextButton(
              child: const Text(
                'Registrate',
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              onPressed: _formRegistration,
            ),
          ),
        Container(
          width: double.infinity,
          height: 40,
          child: TextButton(
            child: const Text(
              '¿Has olvidado tu constraseña?',
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            onPressed: _formRecovery,
          ),
        ),
      ]),
    );
  }
}
