import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

@immutable
class MenuDrawer extends StatelessWidget {
  Observer observerDrawerHeader(ThemeData theme, UiStore uiStore) {
    return Observer(builder: (_) => showDrawerHeader(theme, uiStore));
  }

  Widget showDrawerHeader(ThemeData theme, UiStore uiStore) {
    // Uso los null operator para no que no tire error cuando se esta deslogueando
    // entre que se borro el usuario de la memoria y esta haciendo la redireccion al login.
    // TODO: esta bien hecho o habria que redirigir al login cuando user es null?
    return UserAccountsDrawerHeader(
      accountName: Text(uiStore.user?.fullName ?? ''),
      accountEmail: Text(uiStore.user?.email ?? ''),
      currentAccountPicture: ClipRRect(
        borderRadius: BorderRadius.circular(110),
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        color: theme.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final InheritedProvider provider = InheritedProvider.of(context);
    final ThemeData theme = Theme.of(context);

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          observerDrawerHeader(theme, provider.uiStore),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Historial'),
            onTap: () {
              Navigator.pushNamed(context, '/scanner');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pushNamed(context, '/scanner');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () {
              provider
                  .logoutUser()
                  .then((_) => Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false));
            },
          ),
        ],
      ),
    );
  }
}
