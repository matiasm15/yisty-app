import 'package:yisty_app/models/alert_type.dart';
import 'package:yisty_app/models/food_preference.dart';
import 'package:yisty_app/screens/registration/widgets/privacy_policy.dart';
import 'package:yisty_app/services/food_preference_service.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/services/user_service.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
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

  String _email, _password, _fullName, _passwordRepeat;
  int _preferenceId;
  bool _check = false;
  Future<List<FoodPreference>> _future;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _checkChanged(bool value) {
    setState(() {
      _check = value;
    });
  }

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

  void _userNameChanged(String value) {
    setState(() {
      _fullName = value;
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

  String _emailValidator(String value) {
    if(value.isEmpty) {
      return 'El email no puede ser vacío';
    }

    if(!EmailValidator.validate(value)) {
      return 'El email es inválido';
    }

    return null;
  }

  String _userNameValidator(String value) {
    if(value.isEmpty) {
      return 'El usuario no puede ser vacío';
    }

    if(value.length > 40) {
      return 'El nombre debe tener máximo 40 caracteres';
    }

    return null;
  }

  String _comparePassword(String value) {

    if(value.isEmpty) {
      return 'La contraseña no puede ser vacía';
    }

    if(_password != value) {
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

  void _fromLoginPage() {
    Navigator.of(context).pop();
  }

  String _handleError(Object o) {
      final RegExp exp = RegExp('unique violation');
      if(exp.hasMatch(o.toString())) {
        return 'El $_email ha sido utilizado.';
      }
      return 'Ocurrió un error contactar al administrador.';
  }

  void _createUser (UserService userService, UiStore uiStore, RoundedLoadingButtonController controller) {
    userService.create(email: _email, fullName: _fullName, password:
    _password, preferenceId: _preferenceId)
        .then(
            (_) async {
          Navigator.pushReplacementNamed(context, '/login');
          uiStore.setAlert(
              message: 'Gracias por registrarte! Te enviamos '
                  'un email a $_email para activar tu cuenta y poder empezar a usar Yisty.',
              type: AlertType.SUCCESS
          );
        }
    ).catchError(
            (Object e) => uiStore.setAlert(
            message: _handleError(e),
            type: AlertType.ERROR
        ),
        test: (Object e) => e is BadRequestException
    ).whenComplete(() => controller.reset());
  }

   void _formSubmitted(RoundedLoadingButtonController controller) {
    FocusScope.of(context).unfocus();

    final InheritedProvider provider = InheritedProvider.of(context);
    final UiStore uiStore = provider.uiStore;
    final UserService userService = provider.services.users;
    uiStore.removeAlert();

    if (_formKey.currentState.validate()) {
      if (_preferenceId == null) {
        controller.reset();
        return uiStore.setAlert(
            message: 'Debe selecionar una resctrición',
            type: AlertType.WARNING
        );
      }

      if (!_check) {
        controller.reset();
        return uiStore.setAlert(
            message: 'Debe aceptar términos y condiciones',
            type: AlertType.WARNING
        );
      }

      if (_preferenceId != null && _check) {
        _createUser(userService, uiStore, controller);
      }
    } else {
      controller.reset();
    }

  }

  @override
  void didChangeDependencies() {
    final InheritedProvider provider = InheritedProvider.of(context);
    final FoodPreferenceService foodPreferenceService = provider.services.foodPreferences;

    _future ??= foodPreferenceService.getFoodPreferences();

    super.didChangeDependencies();
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

  Widget _buildFullName() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Focus(
          child: TextFormField(
            enableSuggestions: true,
            autocorrect: true,
            onChanged: _userNameChanged,
            validator: _userNameValidator,
            decoration: const InputDecoration(hintText: 'Nombre', icon: Icon(Icons.person)),
          ),
          onFocusChange: _focusChanged,
        )
    );
  }

  Widget _buildPassword() {
    return Padding(
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
    );
  }

  Widget _buildPasswordRepeat() {
    return Padding(
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
    );
  }

  Widget buildLoading() {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget> [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                strokeWidth: 6,
                backgroundColor: Colors.white,
              )
            ],
          ),
        )
    );
  }

  Widget _buildPreference(BuildContext context) {

    return FutureBuilder<List<FoodPreference>>(
        future: _future,
        builder: (_, AsyncSnapshot<List<FoodPreference>> snapshot) {
          if (snapshot.hasData) {
            final List<FoodPreference> preferences = snapshot.data;
            return _preferenceList(preferences);
          } else if (snapshot.hasError) {
            if (snapshot.error is AppException) {
              return AlertPage(message: snapshot.error.toString());
            } else {
              throw snapshot.error;
            }
          } else {
            return buildLoading();
          }
        }
    );
  }

  List<S2Choice<int>> _formmatPreference(List<FoodPreference> preference) {
    return preference.map((FoodPreference value) =>
        S2Choice<int>(value: value.id, title: value.name))
        .toList();
  }

  Widget _preferenceList(List<FoodPreference> preferences) {
    return Container(
      child: SmartSelect<int>.single(
        value: _preferenceId,
        choiceItems: _formmatPreference(preferences),
        modalTitle: 'Restricción Alimenticia',
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
        // ignore: always_specify_types
        onChange: (state) => setState(()  => {
          //_preference = state.title,
          _preferenceId = state.value
        } ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.green,
          value: _check,
          onChanged: _checkChanged
          ),
        InkWell(
          child: const Text(
            'Aceptar términos y condiciones',
            style: TextStyle(fontSize: 16)
          ),
            onTap: () {
              Navigator.push<PrivacyPolicy>(context,
                  MaterialPageRoute(builder:
                      (BuildContext context) => const PrivacyPolicy()));
            }
        )
      ],
    );
  }

  Widget _buildLoadingButton() {
    return Container(
        width: double.infinity,
        height: 40,
        child: LoadingButton(
          text: 'Registrar',
          onPressed: _formSubmitted,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        _buildEmail(),
        _buildFullName(),
        _buildPassword(),
        _buildPasswordRepeat(),
        _buildPreference(context),
        _buildCheckBox(),
        const SizedBox(height: 15),
        _buildLoadingButton(),
        Container(
          width: double.infinity,
          height: 60,
          child: TextButton(
            child: const Text(
                '¿Tenés una cuenta?',
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