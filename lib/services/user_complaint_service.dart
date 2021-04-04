import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/user_complaint.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class UserComplaintService extends BaseService {
  UserComplaintService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<UserComplaint> create(Map<String, String> body) async {
    final ApiResponse apiResponse = await client.post(
        'user_complaints',
        body: body
    );
    final Map<String, dynamic> json = apiResponse.json() as Map<String, dynamic>;

    return UserComplaint.fromJson(json);
  }
}
