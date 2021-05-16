
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_type.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/services/user_service.dart';
import 'package:yisty_app/widgets/design/loading_button.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

class ConfigurationPasswordFrom extends StatefulWidget {
  const ConfigurationPasswordFrom({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _ConfigurationPasswordFormState createState() => _ConfigurationPasswordFormState();

}

class _ConfigurationPasswordFormState extends State<ConfigurationPasswordFrom> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String get title => 'Cambiar contraseña';
  String _newPassword, _newPasswordRepeat, _oldPassword;

  void _passwordChanged(String value) {
    setState(() {
      _newPassword = value;
    });
  }

  void _passwordRepeatChanged(String value) {
    setState(() {
      _newPasswordRepeat = value;
    });
  }

  void _oldPasswordChanged(String value) {
    setState(() {
      _oldPassword = value;
    });
  }

  String _passwordValidator(String value) {

    if(value.isEmpty) {
      return 'La contraseña no puede ser vacía';
    }

    if(value.length < 8) {
      return 'La contraseña debe tener mínimo 8 caracteres';
    }

    return  null;
  }

  String _comparePassword(String value) {

    if(value.isEmpty) {
      return 'La contraseña no puede ser vacía';
    }

    if(_newPassword != value) {
      return 'La contraseña debe coincidir';
    }

    return null;
  }

  void _focusChanged(bool hasFocus) {
    InheritedProvider.of(context).uiStore.removeAlert();

    if (!hasFocus) {
      _formKey.currentState.validate();
    }
  }
  
  Widget _buildOldPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Focus(
        child: TextFormField(
          enableSuggestions: false,
          autocorrect: false,
          obscureText: true,
          onChanged: _oldPasswordChanged,
          validator: _passwordValidator,
          decoration: const InputDecoration(
              hintText: 'Contraseña anterior',
              icon: Icon(Icons.lock_outline)
          ),
        ),
        onFocusChange: _focusChanged,
      ),
    );
  }


  Widget _buildNewPassword() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Focus(
          child: TextFormField(
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            onChanged: _passwordChanged,
            validator: _passwordValidator,
            decoration: const InputDecoration(hintText: 'Nueva Contraseña', icon: Icon(Icons.lock_outline)),
          ),
          onFocusChange: _focusChanged,
        )
    );
  }

  Widget _buildNewPasswordRepeat() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Focus(
          child: TextFormField(
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            onChanged: _passwordRepeatChanged,
            validator: _comparePassword,
            decoration: const InputDecoration(hintText: 'Repetir nueva contraseña', icon: Icon(Icons.lock_outline)),
          ),
          onFocusChange: _focusChanged,
        )
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 40,
      child: LoadingButton(
        text: 'Guardar',
        onPressed: _formSubmitted,
      ),
    );
  }

  void _formSubmitted(RoundedLoadingButtonController controller) {
      FocusScope.of(context).unfocus();

      final InheritedProvider provider = InheritedProvider.of(context);
      final UiStore uiStore = provider.uiStore;
      final UserService userService = provider.services.users;
      final User user = widget.user;

      if(_formKey.currentState.validate()) {
        userService.updatePassword(
              id: user.id.toString(),
              newPassword: _oldPassword,
              oldPassword: _newPassword
            )
            .then(
                (_) {
                  uiStore.setAlert(
                    message: 'Cambio exitosamente, vuelva iniciar.',
                    type: AlertType.SUCCESS
                  );
                  provider.logoutUser()
                      .then((_) =>
                        Navigator.pushNamedAndRemoveUntil(context, '/login',
                                (Route<dynamic> route) => false));
              }
            ).catchError(
                (Object _) => uiStore.setAlert(
                  message: 'Verifique contraseña anterior sea correcta.',
                  type: AlertType.ERROR
                ),
                test: (Object e) => e is BadRequestException
        );
      }
      controller.reset();
  }


  Widget _buildForm() {
    return Column(
      children: <Widget>[
        Container(
          child:Image.asset(
            'assets/logo.png',
            height: 250,
            width: 200,
          ),
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        ),
        Container(
          margin: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      _buildOldPassword(),
                      _buildNewPassword(),
                      _buildNewPasswordRepeat(),
                      const SizedBox(height: 15),
                      _buildSaveButton()
                  ])
            )
        )
      ]);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      builder: (_) => _buildForm(),
      title: Text(title),
    );

  }
}