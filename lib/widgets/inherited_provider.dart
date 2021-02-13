import 'package:flutter/widgets.dart';
import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/app_service.dart';

class InheritedProvider extends InheritedWidget {
  const InheritedProvider({
    Widget child,
    @required this.uiStore,
    @required this.services
  }) : assert(uiStore != null), super(child: child);

  final UiStore uiStore;
  final AppService services;

  Future<User> loginUser(User user)  {
    services.loginUser(user);

    return uiStore.loginUser(user);
  }

  Future<bool> logoutUser() {
    services.logoutUser();

    return uiStore.logoutUser();
  }

  Future<User> loadUser() async {
    if (uiStore.user == null) {
      final User user = await uiStore.loadUser();
      services.loginUser(user);

      return user;
    } else {
      return Future<User>.value(uiStore.user);
    }
  }

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) {
    return uiStore != oldWidget.uiStore || services != oldWidget.services;
  }

  static InheritedProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedProvider>();
  }
}
