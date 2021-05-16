
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smart_select/smart_select.dart';
import 'package:yisty_app/data/persistence/user_persistence.dart';
import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_type.dart';
import 'package:yisty_app/models/food_preference.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/user_service.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/loading_button.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

class ConfigurationFoodPreferenceForm extends StatefulWidget {
  const ConfigurationFoodPreferenceForm({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  _ConfigurationFoodPreferenceFormState createState() => _ConfigurationFoodPreferenceFormState();
}

class _ConfigurationFoodPreferenceFormState extends State<ConfigurationFoodPreferenceForm> {

  String get title => 'Restricción Alimenticia';
  Future <List<FoodPreference>> _future;
  List<FoodPreference> _foodPreferences;
  int _preferenceId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _future ??= InheritedProvider.of(context).services.foodPreferences.getFoodPreferences();
    super.didChangeDependencies();
  }

  Widget _buildPreference(BuildContext context) {
    return FutureBuilder<List<FoodPreference>>(
        future: _future,
        builder: (_, AsyncSnapshot<List<FoodPreference>> snapshot) {
          if(snapshot.hasData) {
            final List<FoodPreference> foodPreferences = snapshot.data;
            _foodPreferences = snapshot.data;
            return _showPreferences(foodPreferences);

          } else if(snapshot.hasError) {
            if (snapshot.error is AppException) {
              return AlertPage(message: snapshot.error.toString());
            } else {
              throw snapshot.error;
            }
          }
          return LoadingWidget();
        },
    );
  }

  Widget _showPreferences(List<FoodPreference> foodPreferences) {
    //_preferenceId = widget.user.foodPreference.id;
    return Container(
      child: SmartSelect<int>.single(
        value: _preferenceId,
        choiceItems: _formmatPreference(foodPreferences),
        modalTitle: 'Restricción Alimenticia',
        placeholder: 'Selecionar',
        modalStyle: const S2ModalStyle(
          backgroundColor: Colors.white,
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
          _preferenceId = state.value
        } ),
      ),
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

    final InheritedProvider provider = InheritedProvider.of(context);
    final UiStore uiStore = provider.uiStore;
    final UserService userService = provider.services.users;

    if(_formKey.currentState.validate()) {
      userService.updateFoodPreference(id: widget.user.id.toString(),
        foodPreference: _preferenceId.toString())
      .then((_) async {
        uiStore.setAlert(
          message: 'Cambio exitosamente',
          type: AlertType.SUCCESS
        );
        Navigator.pushNamedAndRemoveUntil(context, '/home',
                        (Route<dynamic> route) => false);
        widget.user.foodPreference = _foodPreferences
            .firstWhere(
              (FoodPreference preference) => preference.id == _preferenceId);
        await UserPersistence().saveUser(widget.user);
      }).catchError(
              (Object _) => uiStore.setAlert(
              message: 'Ocurrio un error, vuela intentarlo '
                  'si vuelve suceder comunicarse con un administrador.',
              type: AlertType.ERROR
          ),
          test: (Object e) => e is BadRequestException
      );
    }
    controller.reset();
  }

  Widget _buildForm(BuildContext context) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPreference(context),
                const SizedBox(height: 15),
                _buildSaveButton(),
              ],
            ),
          ),
        )
      ],
    );
  }

  List<S2Choice<int>> _formmatPreference(List<FoodPreference> preference) {
    return preference.map((FoodPreference value) =>
        S2Choice<int>(value: value.id, title: value.name))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      builder: (_) => _buildForm(context),
      title: Text(title),
    );

  }
}