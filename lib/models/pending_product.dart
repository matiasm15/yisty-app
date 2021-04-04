class PendingProduct {
  PendingProduct({this.id, this.barcode, this.image, this.manufacturer, this.name});

  factory PendingProduct.fromJson(Map<String, dynamic> responseData) {
    return PendingProduct(
      id: responseData['id'] as int,
      barcode: responseData['barcode'] as String,
      image: responseData['image'] as String,
      manufacturer: responseData['manufacturer'] as String,
      name: responseData['image'] as String,
    );
  }

  int id;
  String barcode;
  String image;
  String manufacturer;
  String name;
}