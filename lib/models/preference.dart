class Preference {
  Preference({this.id, this.name, this.description});

  factory Preference.formJson(Map<String, dynamic> responseData) {
    return Preference(
      id: responseData['id'] as int,
      name: responseData['name'] as String,
      description: responseData['description'] as String
    );
  }

  int id;
  String name;
  String description;

}