import 'package:yisty_app/models/affiliate_shop.dart';

class Product {
  Product({this.id, this.name, this.image, this.barcode, this.affiliateShops});

  factory Product.fromJson(Map<String, dynamic> responseData) {
    // TODO: change
    final int id = responseData['id'] as int;
    final List<AffiliateShop> shops = List<AffiliateShop>.filled(
        id - 1,
        AffiliateShop(
          url: 'https://www.jumbo.com.ar/',
          name: 'Jumbo',
          description: 'Jumbo te da más!',
          image: 'https://jumboargentina.vteximg.com.br/arquivos/logo-jumbo-200.png?v=637441540705900000'
      )
    );

    return Product(
        id: id,
        name: responseData['name'] as String,
        image: responseData['image'] as String,
        barcode: responseData['barcode'] as String,
        affiliateShops: shops
    );
  }

  int id;
  String name;
  String image;
  String barcode;
  List<AffiliateShop> affiliateShops;

  int shopsQuantity() {
    return affiliateShops.length;
  }
}