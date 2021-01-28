import 'dart:async';

import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class UserService {
  UserService({this.client});

  RestClient client;

  Future<User> authenticate(String email, String password) async {
    final Map<String, dynamic> response = (await client.post(
        'authentication',
        body: <String, String>{
          'strategy': 'local',
          'email': email,
          'password': password
        }
    )).json() as Map<String, dynamic>;

    final String accessToken = response['accessToken'] as String;

    return User.fromJson(response['user'] as Map<String, dynamic>, accessToken);
  }
}
