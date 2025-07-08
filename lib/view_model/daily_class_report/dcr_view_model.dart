import 'package:flutter/material.dart';
import 'package:lbef/model/dcr_model.dart';
import 'package:lbef/repository/daily_class_repository/daily_class_repository.dart';
import '../../data/api_response.dart';

class DcrViewModel with ChangeNotifier {
  final DailyClassRepository _myrepo = DailyClassRepository();
  final List<DCRModel> _dcrList = [];

  ApiResponse<DCRModel> userData = ApiResponse.loading();
  DCRModel? get currentUser => userData.data;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<DCRModel> get dcrList => _dcrList;

  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> fetch(BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      _dcrList.clear();
      final Map<String, dynamic> response = await _myrepo.fetchDailyClassReport(context);
      if (response['classReport']!=null) {
        _dcrList.addAll(response['classReport'] as List<DCRModel>);
      } else {
        userData = ApiResponse.error(response['message'] as String);
      }
      notifyListeners();
    } catch (error) {
      userData = ApiResponse.error("Unexpected error: $error");
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }
}