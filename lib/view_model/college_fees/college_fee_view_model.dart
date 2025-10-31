import 'package:flutter/material.dart';
import 'package:lbef/model/fee_model.dart';
import 'package:lbef/repository/fees_repository/fees_repository.dart';
import 'package:logger/logger.dart';
import 'package:lbef/data/api_response.dart';

class CollegeFeeViewModel with ChangeNotifier {
  final FeesRepository _myRepo = FeesRepository();
  final Logger _logger = Logger();

  ApiResponse<FeeModel> feeDetails = ApiResponse.loading();
  FeeModel? get currentDetails => feeDetails.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setDetails(ApiResponse<FeeModel> response) {
    _logger.i('Setting fee details: ${response.status}');
    feeDetails = response;
    notifyListeners();
  }

  void setLoading(bool value) {
    _logger.i('Loading status set to: $value');
    _isLoading = value;
    Future.microtask(() {
      notifyListeners();
    });
  }

  Future<void> fetch(BuildContext context) async {
    if (_isLoading) {
      _logger.w('Fetch already in progress. Ignoring duplicate call.');
      return;
    }
    setLoading(true);
    try {
      final FeeModel fee = await _myRepo.feeDetails(context);
      if (fee != null) {
        _logger.i('fee details fetched successfully');
        setDetails(ApiResponse.completed(fee));
      } else {
        _logger.w('No fee data available');
        setDetails(ApiResponse.error('No data available'));
      }
    } catch (error, stackTrace) {
      _logger.e('Error fetching fee details',
          error: error, stackTrace: stackTrace);
      setDetails(ApiResponse.error('Error fetching data: $error'));
    } finally {
      setLoading(false);
    }
  }
}
