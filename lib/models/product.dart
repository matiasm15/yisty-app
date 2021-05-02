
class Product {
  Product({
    this.id,
    this.name,
    this.image,
    this.barcode,
    this.foodPreference,
    this.category,
    this.manufacturer,
    this.updatedAt
  });

  factory Product.fromJson(Map<String, dynamic> responseData) {
    return Product(
      id: responseData['id'] as int,
      manufacturer: responseData['manufacturer']['name'] as String,
      category: responseData['category']['name'] as String,
      name: responseData['name'] as String,
      image: responseData['image'] as String,
      barcode: responseData['barcode'] as String,
      foodPreference: responseData['foodPreference'] as bool,
      updatedAt: DateTime.parse(responseData['updatedAt'] as String),
    );
  }

  int id;
  String name;
  String image;
  String barcode;
  String category;
  String manufacturer;
  DateTime updatedAt;
  bool foodPreference;

  bool get isPermitted {
    return foodPreference == true;
  }

  bool get isDenied {
    return foodPreference == false;
  }
}