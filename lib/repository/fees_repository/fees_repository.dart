import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/fees_endpoints.dart';
import 'package:lbef/model/TaxModel.dart';
import 'package:lbef/model/balance_model.dart';
import 'package:lbef/model/credit_note_model.dart';
import 'package:lbef/model/statement.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class FeesRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  var logger = Logger();
  Future<Map<String, dynamic>> getStatements(
      int page, int limit, BuildContext context) async {
    if (kDebugMode) {
      logger.d("${FeesEndpoints.getStatement}?page=$page&size=$limit");
    }
    try {
      dynamic response = await _apiServices
          .getApiResponse("${FeesEndpoints.getStatement}?page=$page&pp=$limit");
      if (response is List) {
        List<StatementModel> statements =
            response.map((e) => StatementModel.fromJson(e)).toList();
        logger.d("statements $statements");
        return {"statements": statements};
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

  Future<Map<String, dynamic>> getReceipts(BuildContext context) async {
    if (kDebugMode) {
      logger.d(FeesEndpoints.getReecipts);
    }
    try {
      dynamic response =
          await _apiServices.getApiResponse(FeesEndpoints.getReecipts);
      if (response is List) {
        List<TaxModel> receipts =
            response.map((e) => TaxModel.fromJson(e)).toList();
        logger.d(" $receipts");
        return {"receipts": receipts};
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
  Future<Map<String, dynamic>> getCredits(BuildContext context) async {
    if (kDebugMode) {
      logger.d(FeesEndpoints.getReecipts);
    }
    try {
      dynamic response =
          await _apiServices.getApiResponse(FeesEndpoints.getCreditNotes);
      if (response is List) {
        List<CreditNoteModel> credits =
            response.map((e) => CreditNoteModel.fromJson(e)).toList();
        logger.d(" $credits");
        return {"credits": credits};
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
  Future getBalance(BuildContext context) async {
    logger.d(FeesEndpoints.balance);
    try {
      dynamic response =
      await _apiServices.getApiResponse(FeesEndpoints.balance);
      if (response['error'] != null && response['error'] == true) {
        Utils.noInternet(
            response['errorMessage'] ?? "Unknown error");
        throw Exception(response['errorMessage'] ?? "Unknown error");
      }
      return BalanceModel.fromJson(response);
    } on TimeoutException {
      Utils.noInternet("No internet connection. Please try again later.");
      return ApiResponse.error("No internet connection. Please try again later.");
    }catch (e) {
      logger.e('error $e.');
      return Utils.noInternet(e.toString());
    }
  }
}
