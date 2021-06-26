class Ingredient {
  Ingredient({this.id, this.name, this.result});

  factory Ingredient.fromJson(Map<String, dynamic> responseData) {
    return Ingredient(
      id: responseData['id'] as int,
      name: responseData['name'] as String,
      result: responseData['result'] as bool,
    );
  }

  int id;
  String name;
  bool result;

  String get capitalizeName {
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }

  bool get isPermitted {
    return result == true;
  }

  bool get isDenied {
    return result == false;
  }

  bool get isUnknown {
    return result == null;
  }
}
