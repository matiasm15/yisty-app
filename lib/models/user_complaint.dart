class UserComplaint {
  UserComplaint({this.id, this.userId, this.productId, this.description});

  factory UserComplaint.fromJson(Map<String, dynamic> responseData) {
    return UserComplaint(
      id: responseData['id'] as int,
      userId: responseData['user_id'] as int,
      productId: responseData['product_id'] as int,
      description: responseData['description'] as String,
    );
  }

  int id;
  int userId;
  int productId;
  String description;
}