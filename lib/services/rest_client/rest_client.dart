import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';

class RestClient {
  RestClient({String accessToken}) {
    authHeaders = <String, String>{'Authorization': accessToken};
  }
  
  final String _baseUrl = 'http://192.168.0.4:3030/';
  Map<String, String> authHeaders;

  set accessToken(String accessToken) {
    authHeaders = <String, String>{'Authorization': 'Bearer $accessToken'};
  }

  Future<ApiResponse> get(String url) async {
    try {
      final http.Response response = await http.get(
        _baseUrl + url,
        headers: authHeaders,
      );

      return ApiResponse(_returnResponse(response));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<ApiResponse> post(String url, {dynamic body, Map<String, String> headers}) async {
    try {
      final http.Response response = await http.post(
        _baseUrl + url,
        body: body,
        headers: headers ?? authHeaders,
      );

      return ApiResponse(_returnResponse(response));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<ApiResponse> put(String url, dynamic body) async {
    try {
      final http.Response response = await http.put(
        _baseUrl + url,
        body: body,
        headers: authHeaders,
      );

      return ApiResponse(_returnResponse(response));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
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