import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:yisty_app/data/stores/ui_singleton.dart';
import 'package:yisty_app/data/stores/ui_store.dart';

@immutable
class MenuDrawer extends StatelessWidget {
  Observer observerDrawerHeader(BuildContext context) {
    return Observer(builder: (_) => showDrawerHeader(context));
  }

  Widget showDrawerHeader(BuildContext context) {
    final UiStore uiStore = UiSingleton().uiStore();

    return UserAccountsDrawerHeader(
      accountName: Text(uiStore.user.name),
      accountEmail: Text(uiStore.user.email),
      currentAccountPicture: ClipRRect(
        borderRadius: BorderRadius.circular(110),
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UiStore uiStore = UiSingleton().uiStore();

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          observerDrawerHeader(context),
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
              uiStore.logoutUser().then((_) => Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false));
            },
          ),
        ],
      ),
    );
  }
}
