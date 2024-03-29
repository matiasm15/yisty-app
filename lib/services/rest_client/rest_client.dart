import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';

class RestClient {
  RestClient({String accessToken, String apiUrl}) {
    _apiUrl = apiUrl;
    authHeaders = <String, String>{'Authorization': accessToken};
  }

  String _apiUrl;
  Map<String, String> authHeaders;
  Duration duration = const Duration(seconds: 90);

  set accessToken(String accessToken) {
    if (accessToken == null) {
      authHeaders = null;
    } else {
      authHeaders = <String, String>{'Authorization': 'Bearer $accessToken'};
    }
  }

  Future<ApiResponse> get(String url) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(_apiUrl + url),
        headers: authHeaders,
      ).timeout(duration);

      return ApiResponse(_returnResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Timeout connection');
    }
  }

  Future<ApiResponse> post(String url, {dynamic body, Map<String, String> headers}) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(_apiUrl + url),
        body: body,
        headers: headers ?? authHeaders,
      ).timeout(duration);

      return ApiResponse(_returnResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Timeout connection');
    }
  }

  Future<ApiResponse> put(String url, dynamic body) async {
    try {
      final http.Response response = await http.put(
        Uri.parse(_apiUrl + url),
        body: body,
        headers: authHeaders,
      ).timeout(duration);

      return ApiResponse(_returnResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Timeout connection');
    }
  }

  Future<ApiResponse> patch(String url, dynamic body) async {
    try {
      final http.Response response = await http.patch(
          Uri.parse(_apiUrl + url),
          body: body,
          headers: authHeaders,
      ).timeout(duration);

      return ApiResponse(_returnResponse(response));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Timeout connection');
    }
  }

  http.Response _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return response;
      case 404:
        throw NotFoundException(response.body.toString());
      case 400:
      case 422:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
