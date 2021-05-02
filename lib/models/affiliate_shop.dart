class AffiliateShop {
  AffiliateShop({this.id, this.name, this.description, this.image, this.url});

  factory AffiliateShop.fromJson(Map<String, dynamic> responseData) {
    final Map<String, dynamic> affiliateShops = responseData['affilate_shops'] as Map<String, dynamic>;

    return AffiliateShop(
      id: affiliateShops['id'] as int,
      name: affiliateShops['name'] as String,
      image: affiliateShops['image'] as String,
      description: responseData['description'] as String,
      url: responseData['url'] as String,
    );
  }

  int id;
  String name;
  String description;
  String image;
  String url;
}