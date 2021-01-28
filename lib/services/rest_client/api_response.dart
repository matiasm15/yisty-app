import 'dart:convert';

import 'package:http/http.dart';

class ApiResponse {
  ApiResponse(this.response);

  final Response response;

  dynamic json() {
    return jsonDecode(response.body.toString());
  }
}