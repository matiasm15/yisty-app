import 'package:yisty_app/models/product.dart';

class FoodPreference {
  FoodPreference({this.id, this.name});

  factory FoodPreference.fromJson(Map<String, dynamic> responseData) {
    return FoodPreference(
      id: responseData['id'] as int,
      name: responseData['name'] as String,
    );
  }

  int id;
  String name;

  // TODO
  bool isPermitted(Product product) {
    return product.id % 3 == 1;
  }

  // TODO
  bool isDenied(Product product) {
    return product.id % 3 == 2;
  }
}