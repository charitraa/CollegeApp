import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/application_endpoints.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class ApplicationRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  var logger = Logger();
  Future<ApiResponse> createApplication(
      dynamic data, File file, BuildContext context) async {
    try {
      logger.d(ApplicationEndpoints.createApplication);
      final response = await _apiServices.postMultipartResponse(
          ApplicationEndpoints.createApplication, data, file);
      logger.d(response);
      return ApiResponse.completed(response);
    } on TimeoutException {
      return Utils.noInternet(
          "No internet connection. Please try again later.");
    } catch (e) {
      logger.w(e);
      Utils.flushBarErrorMessage(e.toString(), context);
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> updateApplication(
      dynamic data, File file, BuildContext context) async {
    try {
      logger.d(ApplicationEndpoints.updateApplications);
      final response = await _apiServices.postMultipartResponse(
          ApplicationEndpoints.createApplication, data, file);
      logger.d(response);

      return ApiResponse.completed(response);
    } on TimeoutException {
      return Utils.noInternet(
          "No internet connection. Please try again later.");
    } catch (e) {
      logger.w(e);
      Utils.flushBarErrorMessage(e.toString(), context);
      return ApiResponse.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchApplications(
      int page, int limit, BuildContext context) async {
    if (kDebugMode) {
      logger.d(
          "${ApplicationEndpoints.getApplications}?page=$page&size=$limit");
    }
    try {
      dynamic response = await _apiServices.getApiResponse(
          "${ApplicationEndpoints.createApplication}?page=$page&pp=$limit");
      if (response is List) {
        //todo change the model over herr
        List<UserModel> applications =
            response.map((e) => UserModel.fromJson(e)).toList();
        logger.d("applications List $applications");
        return {"applications": applications};
      } else {
        throw Exception("Unexpected response format: $response");
      }
    } on TimeoutException {
      return Utils.noInternet(
          "No internet connection. Please try again later.");
    } catch (error) {
      logger.w(error);
      return Utils.flushBarErrorMessage("$error", context);
    }
  }
}
