class AffiliateShop {
  AffiliateShop({this.id, this.name, this.description, this.image, this.url});

  factory AffiliateShop.fromJson(Map<String, dynamic> responseData) {
    return AffiliateShop(
      id: responseData['id'] as int,
      name: responseData['name'] as String,
      description: responseData['description'] as String,
      image: responseData['image'] as String,
      url: responseData['url'] as String,
    );
  }

  int id;
  String name;
  String description;
  String image;
  String url;
}