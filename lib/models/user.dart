import 'package:yisty_app/models/profile.dart';

class User {
  User({this.id, this.fullName, this.email, this.accessToken, this.active});

  factory User.fromJson(Map<String, dynamic> responseData, String accessToken) {
    return User(
        id: responseData['id'] as int,
        fullName: responseData['full_name'] as String,
        email: responseData['email'] as String,
        active: responseData['active'] as bool,
        accessToken: accessToken
    );
  }

  int id;
  String fullName;
  String email;
  String accessToken;
  bool active;
  Profile profile = Profile(id: 1, name: 'Vegano');
}
