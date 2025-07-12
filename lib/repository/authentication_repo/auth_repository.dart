import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';
import '../../data/network/AuthNetworkService.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/NetworkApiService.dart';
import '../../endpoints/auth_endpoints.dart';
import '../../endpoints/profile_endpoints.dart';
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
  Future<bool> recover(BuildContext context, String username, String email,String dob) async {
    var _logger=Logger();
    try {

      _logger.d('Changing password via ${ProfileEndpoints.getProfile}');
      final response = await _apiServices.getPostUrlResponse(
        "${ProfileEndpoints.getProfile}/p1:$username/p2:$email/p3:$dob",
      );
      if (response == null) {
        _logger.w('No response from changePassword API');
        Utils.flushBarErrorMessage("No response from server", context);
        return false;
      }

      _logger.d('Change password response: $response');
      if (response['status'] == 'success' || response.containsKey('success')) {
        Utils.flushBarSuccessMessage("Password changed successfully", context);
        return true;
      } else {
        final errorMessage = response['message'] ?? 'Failed to change password';
        _logger.w('Change password failed: $errorMessage');
        Utils.flushBarErrorMessage(errorMessage, context);
        return false;
      }
    } on TimeoutException {
      _logger.e('Timeout: No internet connection for changing password');
      Utils.flushBarErrorMessage("No internet connection. Please try again later.", context);
      return false;
    } catch (e) {
      _logger.e('changePassword error: $e');
      Utils.flushBarErrorMessage('Failed to change password: $e', context);
      return false;
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