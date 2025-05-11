import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../data/api_response.dart';
import '../../data/network/AuthNetworkService.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/NetworkApiService.dart';
import '../../endpoints/auth_endpoints.dart';
import '../../model/user_model.dart';
import '../../utils/utils.dart';


class AuthRepository {
  final BaseApiServices _apiServices2 = NetworkApiService();
  var logger=Logger();
  final AuthNetworkApiService _apiServices = AuthNetworkApiService();

  Future<dynamic> login(dynamic data, BuildContext context) async {
    try {
      logger.d(AuthEndPoints.authUrl);
      dynamic response =
      await _apiServices.getPostResponse(AuthEndPoints.authUrl, data);

      if (response is Map<String, dynamic> && response.containsKey("err")) {
        Utils.flushBarErrorMessage(response["err"], context);
        return false;
      }

      return ApiResponse.completed(UserModel.fromJson(response));
    } on TimeoutException {
      Utils.flushBarErrorMessage(
          "No internet connection. Please try again later.", context);
      return ApiResponse.error(
          "No internet connection. Please try again later.");
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      return ApiResponse.error(e.toString());
    }
  }



  // Future<dynamic> logout(BuildContext context) async {
  //   try {
  //     final response =
  //     await _apiServices2.getDeleteApiResponse(AuthEndPoints.logout);
  //     if (response != null) {
  //       return ApiResponse.completed(response);
  //     } else {
  //       return ApiResponse.error(response['errorMessage'] ?? "Unknown error");
  //     }
  //   } on TimeoutException {
  //     Utils.flushBarErrorMessage(
  //         "No internet connection. Please try again later.", context);
  //     ApiResponse.error("No internet connection. Please try again later.");
  //     rethrow;
  //   } catch (e) {
  //     ApiResponse.error(e.toString());
  //     rethrow;
  //   }
  // }
}
