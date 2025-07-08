import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lbef/data/network/NetworkApiService.dart';
import 'package:lbef/endpoints/profile_endpoints.dart';
import 'package:lbef/model/profile_model.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class ProfileRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  final _logger = Logger();
  Future<ProfileModel?> getUser(BuildContext context) async {
    try {
      _logger.d('Fetching user from ${ProfileEndpoints.getProfile}');
      final dynamic response =
      await _apiServices.getApiResponse(ProfileEndpoints.getProfile);
      if (response == null) {
        _logger.w('No response from getUser API');
        Utils.flushBarErrorMessage("No response from server", context);
        throw Exception("No response from server");
      }

      _logger.d('Fetched user response: $response');
      return ProfileModel.fromJson(response);
    } on TimeoutException {
      _logger.e('Timeout: No internet connection for fetching user');
      Utils.flushBarErrorMessage("No internet connection. Please try again later.", context);
      throw Exception("No internet connection");
    } catch (e) {
      _logger.e('getUser error: $e');
      Utils.flushBarErrorMessage('Failed to fetch user: $e', context);
      throw e;
    }
  }
}
