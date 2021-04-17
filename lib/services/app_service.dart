import 'package:flutter_config/flutter_config.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/services/affiliate_shops_product_service.dart';
import 'package:yisty_app/services/ingredient_service.dart';
import 'package:yisty_app/services/new_api_service.dart';
import 'package:yisty_app/services/food_preference_service.dart';
import 'package:yisty_app/services/pending_product_service.dart';
import 'package:yisty_app/services/product_service.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';
import 'package:yisty_app/services/user_complaint_service.dart';
import 'package:yisty_app/services/user_scan_service.dart';
import 'package:yisty_app/services/user_service.dart';

class AppService {
  AppService({UiStore uiStore}) {
    uiStore = uiStore;
    apiUrl = FlutterConfig.get('YISTY_API_URL').toString();
    newApiKey = FlutterConfig.get('NEW_API_KEY').toString();
    client = RestClient(apiUrl: apiUrl);

    affiliateShopsProducts = AffiliateShopsProductService(client: client, uiStore: uiStore);
    ingredients = IngredientService(client: client, uiStore: uiStore);
    pendingProducts = PendingProductService(client: client, uiStore: uiStore);
    products = ProductService(client: client, uiStore: uiStore);
    users = UserService(client: client, uiStore: uiStore);
    userComplaints = UserComplaintService(client: client, uiStore: uiStore);
    userScans = UserScanService(client: client, uiStore: uiStore);
    foodPreferences = FoodPreferenceService(client: client, uiStore: uiStore);
    newApis = NewsApiService(apiKey: newApiKey);
  }

  String apiUrl;
  String newApiKey;
  RestClient client;
  UiStore uiStore;

  AffiliateShopsProductService affiliateShopsProducts;
  IngredientService ingredients;
  PendingProductService pendingProducts;
  ProductService products;
  UserService users;
  UserScanService userScans;
  UserComplaintService userComplaints;
  NewsApiService newApis;
  FoodPreferenceService foodPreferences;

  void loginUser(User user)  {
    client.accessToken = user?.accessToken;
  }

  void logoutUser() {
    client.accessToken = null;
  }
}
