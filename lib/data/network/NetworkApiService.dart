import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/utils.dart';
import '../api_exception.dart';
import 'BaseApiService.dart';

class NetworkApiService extends BaseApiServices {
  Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: "application/json"
    };
    final String? session = sp.getString('session');
    if (kDebugMode) {
      print('Session: $session');
    }

    if (session != null && session.isNotEmpty) {
      headers['Authorization'] = 'Bearer $session';
    }
    return headers;
  }

  @override
  Future getPutResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();

      if (kDebugMode) {
        print(data);
        print(url);
      }
      final response = await http
          .put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      )
          .timeout(const Duration(seconds: 10));
      final responseBody = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseBody);
      }
      if (responseBody.containsKey('error')) {
        if (kDebugMode) {
          print('Response Body Error: ${responseBody['error']}');
        }
      }
      responseJson = returnResponse(response);
    } on SocketException {
      Utils.noInternet('No internet connection');
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getApiResponse(String url) async {
    final headers = await _getHeaders();
    dynamic responseJson;
    print(headers);
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      print(response.body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final response = await http
          .delete(
        Uri.parse(url),
        headers: headers,
      )
          .timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print('Response Status Code: ${response.statusCode}');
      }

      if (response.statusCode == 204 || response.body.isEmpty) {
        if (kDebugMode) {
          print('Empty response body with Status Code: ${response.statusCode}');
        }
        return {
          'status': response.statusCode,
          'message': 'No content returned from server',
        };
      }

      final responseBody = jsonDecode(response.body);

      if (kDebugMode) {
        print('Response Body: $responseBody');
      }

      responseBody['status'] = response.statusCode;

      if (responseBody.containsKey('error') && responseBody['error'] == true) {
        if (kDebugMode) {
          print('Response Body Error: ${responseBody['error']}');
        }
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
      throw FetchDataException("Error During Communication!!$e");
    }
    return responseJson;
  }

  @override
  Future<dynamic> postFile(String url, File file) async {
    dynamic responseJson;
    try {
      print(url);
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? session = sp.getString('session');
      if (session == null || session.isEmpty) {
        throw FetchDataException("Session not found");
      }

      String fileExtension = file.path.split('.').last.toLowerCase();

      // Determine content type
      String contentType;
      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
          contentType = 'image/jpeg';
          break;
        case 'png':
          contentType = 'image/png';
          break;
        case 'gif':
          contentType = 'image/gif';
          break;
        default:
          contentType = 'application/octet-stream';
      }

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $session'
        ..files.add(await http.MultipartFile.fromPath(
          'profile_icon',
          file.path,
          contentType:
          MediaType(contentType.split('/')[0], contentType.split('/')[1]),
        ));

      if (kDebugMode) {
        print('Multipart Request Headers: ${request.headers}');
        print('Multipart Request Fields: ${request.fields}');
        print('Multipart Files: ${request.files.map((f) => f.filename)}');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      responseJson = returnResponse(response);
    } on SocketException {
      Utils.noInternet('No internet connection');
      throw FetchDataException("No Internet Connection");
    } on HttpException {
      throw FetchDataException("Could not reach server");
    } on TimeoutException {
      throw FetchDataException("Request Timed Out");
    }

    return responseJson;
  }

  @override
  Future<dynamic> postBanner(String url, File file) async {
    dynamic responseJson;
    try {
      print(url);
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? session = sp.getString('session');
      if (session == null || session.isEmpty) {
        throw FetchDataException("Session not found");
      }

      String fileExtension = file.path.split('.').last.toLowerCase();

      // Determine content type
      String contentType;
      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
          contentType = 'image/jpeg';
          break;
        case 'png':
          contentType = 'image/png';
          break;
        case 'gif':
          contentType = 'image/gif';
          break;
        default:
          contentType = 'application/octet-stream';
      }

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $session'
        ..files.add(await http.MultipartFile.fromPath(
          'banner_icon',
          file.path,
          contentType:
          MediaType(contentType.split('/')[0], contentType.split('/')[1]),
        ));

      if (kDebugMode) {
        print('Multipart Request Headers: ${request.headers}');
        print('Multipart Request Fields: ${request.fields}');
        print('Multipart Files: ${request.files.map((f) => f.filename)}');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      responseJson = returnResponse(response);
    } on SocketException {
      Utils.noInternet('No internet connection');
      throw FetchDataException("No Internet Connection");
    } on HttpException {
      throw FetchDataException("Could not reach server");
    } on TimeoutException {
      throw FetchDataException("Request Timed Out");
    }

    return responseJson;
  }

  @override
  Future<dynamic> postMultipartResponse(
      String url, Map<String, dynamic> fields, File file) async {
    dynamic responseJson;
    try {
      print(url);

      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? session = sp.getString('session');
      if (session == null || session.isEmpty) {
        throw FetchDataException("Session not found");
      }

      // Extract file extension
      String fileExtension = file.path.split('.').last.toLowerCase();

      // Determine content type
      String contentType;
      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
          contentType = 'image/jpeg';
          break;
        case 'png':
          contentType = 'image/png';
          break;
        case 'gif':
          contentType = 'image/gif';
          break;
        default:
          contentType = 'application/octet-stream';
      }

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $session'
        ..fields
            .addAll(fields.map((key, value) => MapEntry(key, value.toString())))
        ..files.add(await http.MultipartFile.fromPath(
          'icon',
          file.path,
          contentType:
          MediaType(contentType.split('/')[0], contentType.split('/')[1]),
        ));

      if (kDebugMode) {
        print('Multipart Request Headers: ${request.headers}');
        print('Multipart Request Fields: ${request.fields}');
        print('Multipart Files: ${request.files.map((f) => f.filename)}');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      responseJson = returnResponse(response);
    } on SocketException {
      Utils.noInternet('No internet connection');
      throw FetchDataException("No Internet Connection");
    } on HttpException {
      throw FetchDataException("Could not reach server");
    } on TimeoutException {
      throw FetchDataException("Request Timed Out");
    }

    return responseJson;
  }

  @override
  Future<dynamic> postKycResponse(String url, Map<String, dynamic> fields,
      Map<String, File?> filePaths) async {
    dynamic responseJson;
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? session = sp.getString('session');
      if (session == null || session.isEmpty) {
        throw FetchDataException("Session not found");
      }
      print(url);
      print(fields);
      final headers = await _getHeaders();
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $session';
      fields.forEach((key, value) {
        if (value is List) {
          request.fields[key] = jsonEncode(value);
        } else {
          request.fields[key] = value.toString();
        }
      });
      for (var entry in filePaths.entries) {
        final file = entry.value;
        final fileExtension = file!.path.split('.').last.toLowerCase();
        String contentType;

        if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
          contentType = 'image/jpeg';
        } else if (fileExtension == 'png') {
          contentType = 'image/png';
        } else if (fileExtension == 'gif') {
          contentType = 'image/gif';
        } else if (fileExtension == 'jpg') {
          contentType = 'image/jpg';
        } else {
          contentType = 'application/octet-stream';
        }

        request.files.add(await http.MultipartFile.fromPath(
          entry.key,
          file.path,
          contentType: MediaType.parse(contentType),
        ));
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      responseJson = returnResponse(response);
    } on SocketException {
      Utils.noInternet('No internet connection');
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> postForm(String url, Map<String, dynamic> fields) async {
    dynamic responseJson;
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? session = sp.getString('session');
      if (session == null || session.isEmpty) {
        throw FetchDataException("Session not found");
      }
      print(url);
      print(fields);
      final headers = await _getHeaders();
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $session';
      fields.forEach((key, value) {
        if (value is List) {
          request.fields[key] = jsonEncode(value);
        } else {
          request.fields[key] = value.toString();
        }
      });

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      responseJson = returnResponse(response);
    } on SocketException {
      Utils.noInternet('No internet connection');
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future putMultipartResponse(String url, File files) async {
    print(url);
    dynamic responseJson;
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? session = sp.getString('session');
      if (session == null || session.isEmpty) {
        throw FetchDataException("Session not found");
      }
      final request = http.MultipartRequest('PUT', Uri.parse(url))
        ..headers['Cookie'] = 'sessionId=$session'
        ..files.add(await http.MultipartFile.fromPath(
          'requisitionSlip',
          files.path,
          contentType: MediaType('image', 'jpeg'),
        ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
      responseJson = returnResponse(response);
    } on SocketException {
      Utils.noInternet('No internet connection');
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic body) async {
    final headers = await _getHeaders();
    print(body);
    dynamic responseJson;
    try {
      Response response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      print('principle ${response.body}');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response, {BuildContext? context}) {
    final responseBody = jsonDecode(response.body);
    String errorMessage = "Something went wrong";
    if (responseBody is Map && responseBody.containsKey('err')) {
      errorMessage = responseBody['err'];
    } else if (responseBody is Map && responseBody.containsKey('error')) {
      errorMessage = responseBody['error'];
    }

    switch (response.statusCode) {
      case 200:
        return responseBody;
      case 400:
        Utils.noInternet("Not Found: $errorMessage");
        BadRequestException(errorMessage);
        return responseBody;
      case 401:
        Utils.noInternet("Not Found: $errorMessage");
        throw UnAuthorizeException(errorMessage);
      case 403:
        FetchDataException("Forbidden: $errorMessage");
        Utils.noInternet("Forbidden Found: $errorMessage");
        return responseBody;

      case 404:
        Utils.noInternet("Not Found: $errorMessage");
        FetchDataException("Not Found: $errorMessage");
        return responseBody;
      case 410:
        Utils.noInternet("Not Found: $errorMessage");
        FetchDataException("Not Found: $errorMessage");

        return responseBody;
      case 500:
        Utils.noInternet("Not Found: $errorMessage");
        throw FetchDataException("Not Found: $errorMessage");
      default:
        Utils.noInternet("Not Found: $errorMessage");
        throw FetchDataException(
            'Error communicating with the server. Status code: ${response.statusCode}');
    }
  }

  @override
  Future putUrlResponse(String url) async {
    final headers = await _getHeaders();

    dynamic responseJson;
    try {
      Response response = await http
          .put(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet Connection");
    }
    return responseJson;
  }

  @override
  Future postUrlResponse(String url) async {
    final headers = await _getHeaders();

    dynamic responseJson;
    try {
      Response response = await http
          .post(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      print(response.body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet Connection");
    }
    return responseJson;
  }
}
