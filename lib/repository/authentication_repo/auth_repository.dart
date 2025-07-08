import 'dart:async';
import 'package:flutter/cupertino.dart';
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
  var logger = Logger();
  final AuthNetworkApiService _apiServices = AuthNetworkApiService();

  Future<dynamic> login(dynamic data, {BuildContext? context}) async {
    try {
      logger.d(AuthEndPoints.authUrl);
      dynamic response = await _apiServices.getPostResponse(AuthEndPoints.authUrl, data, context: context);
      return ApiResponse.completed(UserModel.fromJson(response));
    } on TimeoutException {
      Utils.noInternet("No internet connection. Please try again later.");
      return ApiResponse.error("No internet connection. Please try again later.");
    } catch (e) {
      return ApiResponse.error(" ${e.toString()}");
    }
  }
  Future<dynamic> logout() async {
    try {
      final response =
      await _apiServices2.getDeleteApiResponse(AuthEndPoints.logoutUrl);
      return ApiResponse.completed(UserModel.fromJson(response));
    } on TimeoutException {
      Utils.noInternet("No internet connection. Please try again later.");
      return ApiResponse.error("No internet connection. Please try again later.");
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}