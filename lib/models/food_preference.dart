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
}