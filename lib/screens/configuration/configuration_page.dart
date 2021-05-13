
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/configuration/widgets/configuration_food_preference_form.dart';
import 'package:yisty_app/screens/configuration/widgets/configuration_password_form.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

import 'widgets/configuration_privacy_policy.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key key}) : super (key: key);

  String get title => 'Configuración';


  Widget _buildList(BuildContext context) {

    final InheritedProvider provider = InheritedProvider.of(context);
    final User user = provider.uiStore.user;

    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text(
              'Restricción Alimenticia',
              style: TextStyle(fontSize: 20),

            ),
            subtitle: Text(
                user.foodPreference.name
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              Navigator.push<ConfigurationFoodPreferenceForm>(context,
                  MaterialPageRoute(builder:
                      (BuildContext context) => ConfigurationFoodPreferenceForm(user: user)));
            },
          ),
          ListTile(
            title: const Text(
              'Cambiar contraseña',
              style: TextStyle(fontSize: 20),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              Navigator.push<ConfigurationPasswordFrom>(context,
                  MaterialPageRoute(builder:
                      (BuildContext context) => ConfigurationPasswordFrom(user: user)));
            },
          ),
          ListTile(
            title: const Text(
              'Términos y condiciones',
              style: TextStyle(fontSize: 20),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              Navigator.push<ConfigurationPrivacyPolicy>(context,
                  MaterialPageRoute(builder:
                      (BuildContext context) => const ConfigurationPrivacyPolicy()));

            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      builder: (_) => _buildList(context),
      title: Text(title),
    );
  }
}
