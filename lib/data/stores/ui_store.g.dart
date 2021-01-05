// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UiStore on _UiStore, Store {
  final _$userAtom = Atom(name: '_UiStore.user');

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
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

  final _$loadUserAsyncAction = AsyncAction('_UiStore.loadUser');

  @override
  Future<User> loadUser() {
    return _$loadUserAsyncAction.run(() => super.loadUser());
  }

  final _$loginUserAsyncAction = AsyncAction('_UiStore.loginUser');

  @override
  Future<User> loginUser(Map<String, dynamic> responseData) {
    return _$loginUserAsyncAction.run(() => super.loginUser(responseData));
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
  String toString() {
    return '''
user: ${user},
errorMessage: ${errorMessage}
    ''';
  }
}
