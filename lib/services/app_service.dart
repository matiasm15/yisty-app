import 'package:flutter_config/flutter_config.dart';

import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';
import 'package:yisty_app/services/user_service.dart';

class AppService {
  AppService() {
    apiUrl = FlutterConfig.get('YISTY_API_URL').toString();
    client = RestClient(apiUrl: apiUrl);

    users = UserService(client: client);
  }

  String apiUrl;
  RestClient client;
  UserService users;

  void loginUser(User user)  {
    client.accessToken = user.accessToken;
  }

  void logoutUser() {
    client.accessToken = null;
  }
}
