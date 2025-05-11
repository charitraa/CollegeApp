import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../utils/utils.dart';
import '../api_exception.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class AuthNetworkApiService {
  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: "application/json"
    };
    return headers;
  }
  Future getPostResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final response = await http
          .post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      )
          .timeout(const Duration(seconds: 10));
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody != null) {
        User user = User(
            userRole: responseBody['user_role'],
            email: responseBody['email'],
            accessToken: responseBody['access_token']);
        await UserViewModel().saveUser(user);
      } else {
        throw Exception('Incorrect username or password!!');
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response, {BuildContext? context}) {
    final responseBody = jsonDecode(response.body);
    String errorMessage = "Something went wrong";
    if(responseBody['email'] is List){
      errorMessage = responseBody['email'][0];
    }
    if (responseBody is Map && responseBody.containsKey('err')) {
      errorMessage = responseBody['err'];
    } else if (responseBody is Map && responseBody.containsKey('error')) {
      errorMessage = responseBody['error'];
    }

    switch (response.statusCode) {
      case 200:
        return responseBody;
      case 400:
        Utils.noInternet(errorMessage);
        throw BadRequestException(errorMessage);
      case 401:
        Utils.noInternet(errorMessage);
        return responseBody;
      case 403:
        Utils.noInternet(errorMessage);
        throw FetchDataException("Forbidden: $errorMessage");
      case 404:
        Utils.noInternet(errorMessage);
        throw FetchDataException("Not Found: $errorMessage");
      case 500:
        Utils.noInternet(errorMessage);
        throw FetchDataException("Internal Server Error: $errorMessage");
      default:
        if (context != null) {
          Utils.noInternet(errorMessage);
        }
        throw FetchDataException(
            'Error communicating with the server. Status code: ${response.statusCode}');
    }
  }
}
