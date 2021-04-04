class Ingredient {
  Ingredient({this.id, this.name});

  factory Ingredient.fromJson(Map<String, dynamic> responseData) {
    return Ingredient(
      id: responseData['id'] as int,
      name: responseData['name'] as String
    );
  }

  int id;
  String name;

  // TODO
  bool get isPermitted {
    return id % 3 == 1;
  }

  // TODO
  bool get isDenied {
    return id % 3 == 2;
  }

  // TODO
  bool get isUnknown {
    return id % 3 == 0;
  }
}
