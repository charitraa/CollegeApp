import 'package:flutter/material.dart';
import 'package:lbef/model/routine_model.dart';
import 'package:lbef/repository/class_routine_repository/class_routine_repository.dart';
import 'package:logger/logger.dart';
import 'package:lbef/data/api_response.dart';

class ClassRoutineViewModel with ChangeNotifier {
  final ClassRoutineRepository _myRepo = ClassRoutineRepository();
  final Logger _logger = Logger();

  ApiResponse<RoutineModel> feeDetails = ApiResponse.loading();
  RoutineModel? get currentDetails => feeDetails.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setDetails(ApiResponse<RoutineModel> response) {
    _logger.i('Setting fee details: ${response.status}');
    feeDetails = response;
    notifyListeners();
  }

  void setLoading(bool value) {
    _logger.i('Loading status set to: $value');
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetch(BuildContext context) async {
    if (_isLoading) {
      _logger.w('Fetch already in progress. Ignoring duplicate call.');
      return;
    }
    setLoading(true);
    try {
      final RoutineModel routine = await _myRepo.fetchClassRoutine(context);
      if (routine != null) {
        _logger.i('routine details fetched successfully');
        setDetails(ApiResponse.completed(routine));
      } else {
        _logger.w('No routine data available');
        setDetails(ApiResponse.error('No data available'));
      }
    } catch (error, stackTrace) {
      _logger.e('Error fetching routine details', error: error, stackTrace: stackTrace);
      setDetails(ApiResponse.error('Error fetching data: $error'));
    } finally {
      setLoading(false);
    }
  }
}
