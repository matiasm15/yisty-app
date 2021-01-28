import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yisty_app/models/user.dart';

class UserPersistence {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('token', user.token);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int id = prefs.getInt('id');

    if (id == null) {
      return null;
    }

    return User(
        id: id, name: prefs.getString('name'), email: prefs.getString('email'), token: prefs.getString('token'));
  }

  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('token');

    return true;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('token');
  }
}
