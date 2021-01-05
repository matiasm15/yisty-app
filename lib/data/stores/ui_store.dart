import 'dart:async';
import 'package:mobx/mobx.dart';

import 'package:yisty_app/data/persistence/user_persistence.dart';
import 'package:yisty_app/models/user.dart';

part 'ui_store.g.dart';

class UiStore = _UiStore with _$UiStore;

abstract class _UiStore with Store {
  @observable
  User user;

  @observable
  String errorMessage;

  @action
  Future<User> loadUser() async {
    user = await UserPersistence().getUser();

    return user;
  }

  @action
  Future<User> loginUser(Map<String, dynamic> responseData) async {
    user = User.fromJson(responseData);

    await UserPersistence().saveUser(user);

    return user;
  }

  @action
  Future<bool> logoutUser() async {
    user = null;

    return UserPersistence().removeUser();
  }

  @action
  void setErrorMessage(String message) {
    errorMessage = message;
  }

  @action
  void removeErrorMessage() {
    errorMessage = null;
  }
}
