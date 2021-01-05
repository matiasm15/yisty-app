class User {
  User({this.id, this.name, this.email, this.token});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      id: responseData['id'] as int,
      name: responseData['name'] as String,
      email: responseData['email'] as String,
      token: responseData['token'] as String,
    );
  }

  int id;
  String name;
  String email;
  String token;
}
