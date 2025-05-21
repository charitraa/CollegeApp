import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/notice_board_endpoints.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../../utils/utils.dart';

class CalenderRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  var logger = Logger();
  Future<Map<String, dynamic>> fetchCalender(
       BuildContext context) async {
    if (kDebugMode) {
      logger.d(
          NoticeBoardEndpoints.fetch);
    }
    try {
      dynamic response = await _apiServices.getApiResponse(
          NoticeBoardEndpoints.fetch);
      if (response is List) {
        //todo change the model over herr
        List<UserModel> calender =
        response.map((e) => UserModel.fromJson(e)).toList();
        logger.d("calender List $calender");
        return {"calender": calender};
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
