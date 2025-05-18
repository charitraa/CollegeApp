import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/download_forms_endpoints.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../../utils/utils.dart';

class ApplicationRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  var logger = Logger();
  Future<Map<String, dynamic>> getDocuments(
      int page, int limit, BuildContext context) async {
    if (kDebugMode) {
      logger.d(
          "${DownloadFormsEndpoints.getForms}?page=$page&size=$limit");
    }
    try {
      dynamic response = await _apiServices.getApiResponse(
          "${DownloadFormsEndpoints.getForms}?page=$page&size=$limit");
      if (response is List) {
        //todo change the model over herr
        List<UserModel> forms =
        response.map((e) => UserModel.fromJson(e)).toList();
        logger.d("applications List $forms");
        return {"forms": forms};
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
