import 'package:yisty_app/models/food_preference.dart';

class User {
  User({this.id, this.fullName, this.email, this.accessToken, this.active, this.foodPreference});

  factory User.fromJson(Map<String, dynamic> responseData, String accessToken) {
    return User(
        id: responseData['id'] as int,
        fullName: responseData['full_name'] as String,
        email: responseData['email'] as String,
        active: responseData['active'] as bool,
        accessToken: accessToken,
        foodPreference: FoodPreference.fromJson(responseData['food_preference'] as Map<String, dynamic>)
    );
  }

  int id;
  String fullName;
  String email;
  String accessToken;
  bool active;
  FoodPreference foodPreference;
}
