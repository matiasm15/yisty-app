import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:yisty_app/data/persistence/user_persistence.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/models/alert_type.dart';

part 'ui_store.g.dart';

class UiStore = _UiStore with _$UiStore;

abstract class _UiStore with Store {
  @observable
  EdgeInsets screenPadding;

  @observable
  User _user;

  @observable
  String _message;

  @observable
  AlertType _alertType;

  User get user {
    return _user;
  }

  String get message {
    return _message;
  }

  AlertType get alertType {
    return _alertType;
  }

  @action
  Future<User> loadUser() async {
    _user = await UserPersistence().getUser();

    return _user;
  }

  @action
  Future<User> loginUser(User user) async {
    _user = user;

    await UserPersistence().saveUser(user);

    return user;
  }

  @action
  Future<bool> logoutUser() async {
    _user = null;

    return UserPersistence().removeUser();
  }

  @action
  void setScreenPadding(EdgeInsets padding) {
    screenPadding = padding;
  }


  @action
  void setAlert({String message, AlertType type}) {
    _message = message;
    _alertType = type;
  }

  @action
  void removeAlert() {
    _message = null;
    _alertType = null;
  }
}
