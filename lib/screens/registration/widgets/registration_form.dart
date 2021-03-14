import 'package:yisty_app/models/alert_tpye.dart';
import 'package:yisty_app/services/preference_service.dart';
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
import 'package:yisty_app/models/preference.dart';
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
  Future<List<Preference>> _future;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    InheritedProvider.of(context).uiStore.removeMessage();

    if (!hasFocus) {
      _formKey.currentState.validate();
    }
  }

  void _fromLoginPage() {
    Navigator.of(context).pop();
  }

   void _formSubmitted(RoundedLoadingButtonController controller) {
    FocusScope.of(context).unfocus();

    final InheritedProvider provider = InheritedProvider.of(context);
    final UiStore uiStore = provider.uiStore;
    final UserService userService = provider.services.users;
    uiStore.removeMessage();
    uiStore.removeAlertType();

    if (_formKey.currentState.validate()) {
        if(_preferenceId == null) {
          uiStore.setAlertType(AlertType.WARNING);
          uiStore.setMessage('Debe selecionar una resctrición');
        } else {
          userService.create(email: _email, fullName: _fullName, password:
            _password, preferenceId: _preferenceId)
          .then(
              (_) => {
                uiStore.setAlertType(AlertType.SUCCESS),
                uiStore.setMessage('Gracias por registrarte! Te enviamos '
                    'un email a '+ _email + ' para activar tu cuenta y poder empezar a usar Yisty'),
                Navigator.pushReplacementNamed(context, '/login')
              }
          ).catchError(
              (Object _) =>  {
                uiStore.setAlertType(AlertType.ERROR),
                uiStore.setMessage('Ocurrió un error contactar al administrador')
              },
              test: (Object e) => e is BadRequestException
          );
        }
        controller.reset();
    } else {
      controller.reset();
    }
  }

  @override
  void didChangeDependencies() {
    final InheritedProvider provider = InheritedProvider.of(context);
    final PreferenceService preferenceService = provider.services.preferenceService;

    _future ??= preferenceService.getPreferences();

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

    return FutureBuilder<List<Preference>>(
        future: _future,
        builder: (_, AsyncSnapshot<List<Preference>> snapshot) {
          if (snapshot.hasData) {
            final List<Preference> preferences = snapshot.data;
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

  List<S2Choice<int>> _formmatPreference(List<Preference> preference) {
    return preference.map((Preference value) =>
        S2Choice<int>(value: value.id, title: value.name))
        .toList();
  }

  Widget _preferenceList(List<Preference> preferences) {
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