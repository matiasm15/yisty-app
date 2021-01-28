import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';
import 'package:yisty_app/services/user_service.dart';

class AppService {
  AppService() {
    users = UserService(client: client);
  }

  final RestClient client = RestClient();
  UserService users;

  void loginUser(User user)  {
    client.accessToken = user.accessToken;
  }

  void logoutUser() {
    client.accessToken = null;
  }
}