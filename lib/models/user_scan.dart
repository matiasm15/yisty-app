import 'package:yisty_app/models/product.dart';

class UserScan {
  UserScan({this.id, this.product, this.date});

  factory UserScan.fromJson(Map<String, dynamic> responseData) {
    return UserScan(
      id: responseData['id'] as int,
      product: responseData['product'] as Product,
      date: responseData['date'] as DateTime,
    );
  }

  int id;
  Product product;
  DateTime date;
}