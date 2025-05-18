import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/class_report_endpoints.dart';
import 'package:lbef/endpoints/routine_endpoints.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../../utils/utils.dart';

class ClassRoutineRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  var logger = Logger();
  Future<Map<String, dynamic>> fetchClassRoutine(
      int page, int limit, BuildContext context) async {
    if (kDebugMode) {
      logger.d("${RoutineEndpoints.getRoutine}?page=$page&size=$limit");
    }
    try {
      dynamic response = await _apiServices.getApiResponse(
          "${RoutineEndpoints.getRoutine}?page=$page&size=$limit");
      if (response is List) {
        //todo change the model over herr
        List<UserModel> routine =
        response.map((e) => UserModel.fromJson(e)).toList();
        logger.d("daily class report List $routine");
        return {"classRoutine": routine};
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
