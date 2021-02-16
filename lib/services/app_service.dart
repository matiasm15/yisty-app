import 'package:flutter_config/flutter_config.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/new_api_service.dart';
import 'package:yisty_app/services/preference_service.dart';
import 'package:yisty_app/services/product_service.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';
import 'package:yisty_app/services/user_scan_service.dart';
import 'package:yisty_app/services/user_service.dart';

class AppService {
  AppService({UiStore uiStore}) {
    uiStore = uiStore;
    apiUrl = FlutterConfig.get('YISTY_API_URL').toString();
    newApiKey = FlutterConfig.get('NEW_API_KEY').toString();
    client = RestClient(apiUrl: apiUrl);

    products = ProductService(client: client, uiStore: uiStore);
    users = UserService(client: client, uiStore: uiStore);
    userScans = UserScanService(client: client, uiStore: uiStore);
    preferenceService = PreferenceService(client: client, uiStore: uiStore);
    newsApiService = NewsApiService(apiKey: newApiKey);
  }

  String apiUrl;
  String newApiKey;
  RestClient client;
  UiStore uiStore;

  ProductService products;
  UserService users;
  UserScanService userScans;
  NewsApiService newsApiService;
  PreferenceService preferenceService;

  void loginUser(User user)  {
    client.accessToken = user?.accessToken;
  }

  void logoutUser() {
    client.accessToken = null;
  }
}
