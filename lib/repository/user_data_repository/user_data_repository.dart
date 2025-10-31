import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/NetworkApiService.dart';
import '../../endpoints/user_endpoints.dart';
import '../../model/user_model.dart';
import '../../utils/utils.dart';

class UserDataRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  var logger = Logger();
  Future getUser(BuildContext context) async {
    logger.d(UserEndpoints.fetchUser);
    try {
      dynamic response =
      await _apiServices.getApiResponse(UserEndpoints.fetchUser);
      if (response['error'] != null && response['error'] == true) {
        Utils.noInternet(
            response['errorMessage'] ?? "Unknown error");
        throw Exception(response['errorMessage'] ?? "Unknown error");
      }
      return UserModel.fromJson(response);
    } on TimeoutException {
      Utils.noInternet("No internet connection. Please try again later.");
      return ApiResponse.error("No internet connection. Please try again later.");
    }catch (e) {
      logger.e('error $e.');
      return Utils.noInternet(e.toString());
    }
  }
}

