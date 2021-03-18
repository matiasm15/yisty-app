// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UiStore on _UiStore, Store {
  final _$screenPaddingAtom = Atom(name: '_UiStore.screenPadding');

  @override
  EdgeInsets get screenPadding {
    _$screenPaddingAtom.reportRead();
    return super.screenPadding;
  }

  @override
  set screenPadding(EdgeInsets value) {
    _$screenPaddingAtom.reportWrite(value, super.screenPadding, () {
      super.screenPadding = value;
    });
  }

  final _$_userAtom = Atom(name: '_UiStore._user');

  @override
  User get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(User value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  final _$_messageAtom = Atom(name: '_UiStore._message');

  @override
  String get _message {
    _$_messageAtom.reportRead();
    return super._message;
  }

  @override
  set _message(String value) {
    _$_messageAtom.reportWrite(value, super._message, () {
      super._message = value;
    });
  }

  final _$_alertTypeAtom = Atom(name: '_UiStore._alertType');

  @override
  AlertType get _alertType {
    _$_alertTypeAtom.reportRead();
    return super._alertType;
  }

  @override
  set _alertType(AlertType value) {
    _$_alertTypeAtom.reportWrite(value, super._alertType, () {
      super._alertType = value;
    });
  }

  final _$loadUserAsyncAction = AsyncAction('_UiStore.loadUser');

  @override
  Future<User> loadUser() {
    return _$loadUserAsyncAction.run(() => super.loadUser());
  }

  final _$loginUserAsyncAction = AsyncAction('_UiStore.loginUser');

  @override
  Future<User> loginUser(User user) {
    return _$loginUserAsyncAction.run(() => super.loginUser(user));
  }

  final _$logoutUserAsyncAction = AsyncAction('_UiStore.logoutUser');

  @override
  Future<bool> logoutUser() {
    return _$logoutUserAsyncAction.run(() => super.logoutUser());
  }

  final _$_UiStoreActionController = ActionController(name: '_UiStore');

  @override
  void setScreenPadding(EdgeInsets padding) {
    final _$actionInfo = _$_UiStoreActionController.startAction(
        name: '_UiStore.setScreenPadding');
    try {
      return super.setScreenPadding(padding);
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAlert({String message, AlertType type}) {
    final _$actionInfo =
        _$_UiStoreActionController.startAction(name: '_UiStore.setAlert');
    try {
      return super.setAlert(message: message, type: type);
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAlert() {
    final _$actionInfo =
        _$_UiStoreActionController.startAction(name: '_UiStore.removeAlert');
    try {
      return super.removeAlert();
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screenPadding: ${screenPadding}
    ''';
  }
}
