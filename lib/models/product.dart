class Product {
  Product({this.id, this.name, this.image, this.barcode});

  factory Product.fromJson(Map<String, dynamic> responseData) {
    return Product(
        id: responseData['id'] as int,
        name: responseData['name'] as String,
        image: responseData['image'] as String,
        barcode: responseData['barcode'] as String,
    );
  }

  int id;
  String name;
  String image;
  String barcode;

  // TODO
  int shopsQuantity() {
    return id - 1;
  }
}