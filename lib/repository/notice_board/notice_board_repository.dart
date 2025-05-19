import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/download_forms_endpoints.dart';
import 'package:lbef/endpoints/notice_board_endpoints.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../../utils/utils.dart';

class NoticeBoardRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  var logger = Logger();
  Future<Map<String, dynamic>> fetchNotices(
      int page, int limit, BuildContext context) async {
    if (kDebugMode) {
      logger.d(
          "${NoticeBoardEndpoints.fetch}?page=$page&size=$limit");
    }
    try {
      dynamic response = await _apiServices.getApiResponse(
          "${NoticeBoardEndpoints.fetch}?page=$page&pp=$limit");
      if (response is List) {
        //todo change the model over herr
        List<UserModel> notices =
        response.map((e) => UserModel.fromJson(e)).toList();
        logger.d("notice board List $notices");
        return {"notices": notices};
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
