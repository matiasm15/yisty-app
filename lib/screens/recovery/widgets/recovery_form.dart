

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_type.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/services/user_service.dart';
import 'package:yisty_app/widgets/design/loading_button.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

@immutable
class RecoveryForm extends StatefulWidget {
  const RecoveryForm({Key key}) : super (key: key);

  @override
  _RecoveryFormState createState() => _RecoveryFormState();
}

class _RecoveryFormState extends State<RecoveryForm> {

  String _email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _emailValidator(String value) {
    if(value.isEmpty) {
      return 'El email no puede ser vacío';
    }

    if(!EmailValidator.validate(value)) {
      return 'El email es inválido';
    }

    return null;
  }

  void _emailChanged(String value) {
    setState(() {
      _email = value;
    });
  }

  void _focusChanged(bool hasFocus) {
    InheritedProvider.of(context).uiStore.removeAlert();

    if (!hasFocus) {
      _formKey.currentState.validate();
    }
  }

  void _submitted(RoundedLoadingButtonController controller) {
    FocusScope.of(context).unfocus();

    final InheritedProvider provider = InheritedProvider.of(context);
    final UiStore uiStore = provider.uiStore;
    final UserService userService = provider.services.users;    // call service recovery password
    uiStore.removeAlert();

    if(_formKey.currentState.validate()) {
      _recoveryPassword(userService, uiStore, controller);
    }
    controller.reset();
  }

  void _recoveryPassword(UserService userService, UiStore uiStore,
      RoundedLoadingButtonController controller) {
    userService.passwordRecovery(email: _email)
        .then((_) async {
          Navigator.pushReplacementNamed(context, '/login');
          uiStore.setAlert(
            message: '¡Gracias!, Te enviamos un email a $_email para '
                'recuperar tu contraseña.',
            type: AlertType.SUCCESS
          );
    }).catchError(
        (Object e) => uiStore.setAlert(
          message: 'Ocurrió un error vuelva a intentarlo.',
          type: AlertType.ERROR
        ),
        test: (Object e) => e is BadRequestException
    ).whenComplete(() => controller.reset());
  }

  void _fromLoginPage() {
    Navigator.of(context).pop();
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Focus(
        child: TextFormField(
          enableSuggestions: true,
          autocorrect: true,
          obscureText: false,
          onChanged: _emailChanged,
          validator: _emailValidator,
          decoration: const InputDecoration(hintText: 'Email', icon: Icon(Icons.alternate_email)),
        ),
        onFocusChange: _focusChanged,
      ),
    );
  }

  Widget _buildMessage() {
    return const Text(
        'Ingresa el correo electrónico asociado a la cuenta, te estaremos '
            'enviando las instrucciones para restablecer la contraseña'
        , style: TextStyle(fontSize: 15.0),
        textAlign: TextAlign.justify
    );
  }

  Widget _buildButton() {
    return Container(
        width: double.infinity,
        height: 40,
        child: LoadingButton(
          text: 'Recuperar contraseña',
          onPressed: _submitted,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMessage(),
            const SizedBox(height: 10.0,),
            _buildEmail(),
            const SizedBox(height: 10.0,),
            _buildButton(),
            Container(
              width: double.infinity,
              height: 60,
              child: TextButton(
                child: const Text(
                  '¿Ya tienes tu contraseña?',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: _fromLoginPage,
              ),
            )
          ],
      ),
    );
  }
}