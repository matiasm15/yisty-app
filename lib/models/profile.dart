import 'package:yisty_app/models/product.dart';

class Profile {
  Profile({this.id, this.name});

  factory Profile.fromJson(Map<String, dynamic> responseData) {
    return Profile(
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