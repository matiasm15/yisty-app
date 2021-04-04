import 'package:yisty_app/models/product.dart';

class UserScan {
  UserScan({this.id, this.product, this.date});

  factory UserScan.fromJson(Map<String, dynamic> responseData) {
    return UserScan(
      id: responseData['id'] as int,
      product: Product.fromJson(responseData['product'] as Map<String, dynamic>),
      date: DateTime.parse(responseData['date'] as String),
    );
  }

  int id;
  Product product;
  DateTime date;
}