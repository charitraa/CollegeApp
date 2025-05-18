import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/class_report_endpoints.dart';
import 'package:lbef/endpoints/notice_board_endpoints.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../../utils/utils.dart';

class DailyClassRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  var logger = Logger();
  Future<Map<String, dynamic>> fetchDailyClassReport(
      int page, int limit, BuildContext context) async {
    if (kDebugMode) {
      logger.d("${ClassReportEndpoints.getReports}?page=$page&size=$limit");
    }
    try {
      dynamic response = await _apiServices.getApiResponse(
          "${ClassReportEndpoints.getReports}?page=$page&size=$limit");
      if (response is List) {
        //todo change the model over herr
        List<UserModel> classReport =
            response.map((e) => UserModel.fromJson(e)).toList();
        logger.d("daily class report List $classReport");
        return {"classReport": classReport};
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

  Future<Map<String, dynamic>> reportDetails(
      String id, int page, int limit, BuildContext context) async {
    if (kDebugMode) {
      logger.d(
          "${ClassReportEndpoints.getReports}?userId=$id&page=$page&size=$limit");
    }
    try {
      dynamic response = await _apiServices.getApiResponse(
          "${ClassReportEndpoints.getReports}?page=$page&size=$limit");
      if (response is List) {
        //todo change the model over herr
        List<UserModel> dcr =
            response.map((e) => UserModel.fromJson(e)).toList();
        logger.d("class detail List $dcr");
        return {"dcr": dcr};
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
