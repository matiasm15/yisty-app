import 'dart:async';
import 'dart:ffi';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class UserService extends BaseService {
  UserService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<User> authenticate(String email, String password) async {
    final ApiResponse apiResponse = await client.post(
        'authentication',
        body: <String, String>{
          'strategy': 'local',
          'email': email,
          'password': password
        }
    );
    final Map<String, dynamic> json = apiResponse.json() as Map<String, dynamic>;

    final String accessToken = json['accessToken'] as String;

    return User.fromJson(json['user'] as Map<String, dynamic>, accessToken);
  }

  Future<Void> create({String email, String fullName, String password, int preferenceId}) async {
    await client.post(
      'users',
      body: <String, Object> {
        'email': email,
        'full_name': fullName,
        'password': password,
        'profileId': '1',
        'foodPreferenceId' : preferenceId.toString()
      }
    );
  }

  Future<Void> updateFoodPreference({String id, String foodPreference}) async {
    await client.patch(
        'users/$id',
        <String, String>{
          'foodPreferenceId': foodPreference
        });
  }

  Future<Void> updatePassword({String id, String oldPassword, String newPassword}) async {
    await client.patch(
        'users/$id'  ,
        <String, String>{
          'password': oldPassword,
          'newPassword': newPassword
        });
  }
}
