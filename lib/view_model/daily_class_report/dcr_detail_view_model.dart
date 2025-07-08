import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lbef/data/api_response.dart';
import 'package:lbef/model/dcr_detail_model.dart';
import 'package:lbef/repository/daily_class_repository/daily_class_repository.dart';

class DcrDetailViewModel with ChangeNotifier {
  final DailyClassRepository _myRepo = DailyClassRepository();
  final Logger _logger = Logger();

  ApiResponse<DCRDetailModel> dcrDetails = ApiResponse.loading();
  DCRDetailModel? get currentDetails => dcrDetails.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setDetails(ApiResponse<DCRDetailModel> response) {
    _logger.i('Setting DCR details: ${response.status}');
    dcrDetails = response;
    notifyListeners();
  }

  void setLoading(bool value) {
    _logger.i('Loading status set to: $value');
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetch(String subjectId, String facultyId, BuildContext context) async {
    if (_isLoading) {
      _logger.w('Fetch already in progress. Ignoring duplicate call.');
      return;
    }

    _logger.i('Fetching DCR details for subjectId: $subjectId, facultyId: $facultyId');
    setLoading(true);

    try {
      final DCRDetailModel dcr = await _myRepo.reportDetails(subjectId, facultyId, context);
      if (dcr != null) {
        _logger.i('DCR details fetched successfully');
        setDetails(ApiResponse.completed(dcr));
      } else {
        _logger.w('No DCR data available');
        setDetails(ApiResponse.error('No data available'));
      }
    } catch (error, stackTrace) {
      _logger.e('Error fetching DCR details', error: error, stackTrace: stackTrace);
      setDetails(ApiResponse.error('Error fetching data: $error'));
    } finally {
      setLoading(false);
    }
  }
}
