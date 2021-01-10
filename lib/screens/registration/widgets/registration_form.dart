
import 'dart:async';

import 'package:yisty_app/widgets/design/loading_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:smart_select/smart_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:email_validator/email_validator.dart';


@immutable
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key key}) : super (key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  String _email, _password, _passwordRepeat, _selected;

  // get data restriction back
  List<S2Choice<int>> restriction = [
    S2Choice<int>(value: 1, title: 'Vegetariano'),
    S2Choice<int>(value: 2, title: 'Vegano'),
    S2Choice<int>(value: 3, title: 'Celiaco'),
  ];

  final _formKey = GlobalKey<FormState>();

  void _emailChanged(String value) {
    setState(() {
      _email = value;
    });
  }

  void _passwordChanged(String value) {
    setState(() {
      _password = value;
    });
  }

  void _passwordRepeatChanged(String value) {
    setState(() {
      _passwordRepeat = value;
    });
  }

  String _passwordValidator(String value) {

    if(value.isEmpty) {
      return 'La contraseña no puede ser vacia';
    }

    if(value.length < 8) {
      return 'La contraseña debe tener minímo 8 caracteres';
    }
    
    return  null;
  }

  String _emailValidator(String value) {
    if(value.isEmpty) {
      return 'El email no puede ser vacío';
    }

    if(!EmailValidator.validate(value)) {
      return 'El email es inválido';
    }

    return null;
  }

  String _comparePassword(String value) {

    if(value.isEmpty) {
      return 'El contraseña no puede ser vacío';
    }

    if(!identical(_password, value)) {
      return 'El contraseña debe coincidir';
    }

    return null;
  }

  void _focusChanged(bool hasFocus) {
    InheritedProvider.of(context).uiStore.removeErrorMessage();

    if (!hasFocus) {
      _formKey.currentState.validate();
    }
  }

  void _fromLoginPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }

   void _formSubmitted(RoundedLoadingButtonController controller) {
    FocusScope.of(context).unfocus();

    final UiStore uiStore = InheritedProvider.of(context).uiStore;
    uiStore.removeErrorMessage();
    
    if (_formKey.currentState.validate()) {

      Timer(const Duration(seconds: 3), () {

        if(_selected == null || _selected.isEmpty) {
          uiStore.setErrorMessage("Debe selecionar una restricción");
        }
        // first send data to back
        // Here message success then It goes /login
        controller.reset();
      });

    } else {

      controller.reset();
    }
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
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: false,
                  onChanged: _emailChanged,
                  validator: _emailValidator,
                  decoration: const InputDecoration(hintText: 'Email', icon: Icon(Icons.alternate_email)),
                ),
                onFocusChange: _focusChanged,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Focus(
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    onChanged: _passwordChanged,
                    validator: _passwordValidator,
                    decoration: const InputDecoration(hintText: 'Contraseña', icon: Icon(Icons.lock_outline)),
                ),
                  onFocusChange: _focusChanged,
              )
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Focus(
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    onChanged: _passwordRepeatChanged,
                    validator: _comparePassword,
                    decoration: const InputDecoration(hintText: 'Repetir contraseña', icon: Icon(Icons.lock_outline)),
                  ),
                  onFocusChange: _focusChanged,
                )
            ),
            Container(
              child: SmartSelect.single(
                  value: _selected,
                  choiceItems: restriction,
                  modalTitle: 'Restrición Alimenticia',
                  placeholder: 'Selecionar',
                  modalStyle: const S2ModalStyle(
                    backgroundColor: Colors.yellow,
                  ),
                  modalHeaderStyle: const S2ModalHeaderStyle(
                    backgroundColor: Colors.green,
                    centerTitle: true,
                    textStyle: TextStyle(
                      color: Colors.black,
                    )
                  ),
                  modalType: S2ModalType.bottomSheet,
                  modalConfig: const S2ModalConfig(
                    style: S2ModalStyle(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      )
                    )
                  ),
                  onChange: (state) => setState(()  => _selected = state.title),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 40,
          child: LoadingButton(
            text: 'Registar',
            onPressed: _formSubmitted,
          )
        ),
        Container(
          width: double.infinity,
          height: 60,
          child: TextButton(
            child: const Text('¿Tenes una cuenta?'),
            onPressed: _fromLoginPage,
          ),
        )
      ],
      ),
    );
  }

}