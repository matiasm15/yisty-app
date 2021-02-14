// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UiStore on _UiStore, Store {
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

  final _$errorMessageAtom = Atom(name: '_UiStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$successMessageAtom = Atom(name: '_UiStore.successMessage');

  @override
  String get successMessage {
    _$successMessageAtom.reportRead();
    return super.successMessage;
  }

  @override
  set successMessage(String value) {
    _$successMessageAtom.reportWrite(value, super.successMessage, () {
      super.successMessage = value;
    });
  }

  final _$warningMessageAtom = Atom(name: '_UiStore.warningMessage');

  @override
  String get warningMessage {
    _$warningMessageAtom.reportRead();
    return super.warningMessage;
  }

  @override
  set warningMessage(String value) {
    _$warningMessageAtom.reportWrite(value, super.warningMessage, () {
      super.warningMessage = value;
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
  void setErrorMessage(String message) {
    final _$actionInfo = _$_UiStoreActionController.startAction(
        name: '_UiStore.setErrorMessage');
    try {
      return super.setErrorMessage(message);
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeErrorMessage() {
    final _$actionInfo = _$_UiStoreActionController.startAction(
        name: '_UiStore.removeErrorMessage');
    try {
      return super.removeErrorMessage();
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSuccessMessage(String message) {
    final _$actionInfo = _$_UiStoreActionController.startAction(
        name: '_UiStore.setSuccessMessage');
    try {
      return super.setSuccessMessage(message);
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSuccessMessage() {
    final _$actionInfo = _$_UiStoreActionController.startAction(
        name: '_UiStore.removeSuccessMessage');
    try {
      return super.removeSuccessMessage();
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWarningMessage(String message) {
    final _$actionInfo = _$_UiStoreActionController.startAction(
        name: '_UiStore.setWarningMessage');
    try {
      return super.setWarningMessage(message);
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeWarningMessage() {
    final _$actionInfo = _$_UiStoreActionController.startAction(
        name: '_UiStore.removeWarningMessage');
    try {
      return super.removeWarningMessage();
    } finally {
      _$_UiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
successMessage: ${successMessage},
warningMessage: ${warningMessage}
    ''';
  }
}
