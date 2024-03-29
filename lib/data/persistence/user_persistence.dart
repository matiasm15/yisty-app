import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yisty_app/models/food_preference.dart';

import 'package:yisty_app/models/user.dart';

class UserPersistence {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', user.id);
    prefs.setString('fullName', user.fullName);
    prefs.setString('email', user.email);
    prefs.setString('accessToken', user.accessToken);
    prefs.setInt('foodPreference.id', user.foodPreference.id);
    prefs.setString('foodPreference.name', user.foodPreference.name);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int id = prefs.getInt('id');

    if (id == null) {
      return null;
    }

    return User(
        id: id,
        fullName: prefs.getString('fullName'),
        email: prefs.getString('email'),
        accessToken: prefs.getString('accessToken'),
        active: prefs.getBool('active'),
        foodPreference: FoodPreference(id: prefs.getInt('foodPreference.id'),
          name: prefs.getString('foodPreference.name')));
  }

  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('id');
    prefs.remove('fullName');
    prefs.remove('email');
    prefs.remove('active');
    prefs.remove('accessToken');
    prefs.remove('foodPreference.id');
    prefs.remove('foodPreference.name');

    return true;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('accessToken');
  }
}
