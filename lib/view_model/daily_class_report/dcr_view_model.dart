import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/repository/daily_class_repository/daily_class_repository.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class DcrViewModel with ChangeNotifier {
  final DailyClassRepository _myrepo = DailyClassRepository();
  //todo: Change model name based on that u wanna display
  final List<UserModel> _dcrList = [];
  int _currentPage = 1;
  int _limit = 10;
  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserModel> get dcrList => _dcrList;

  int get currentPage => _currentPage;
  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> fetch(BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      _currentPage = 1;
      _dcrList.clear();
      final Map<String, dynamic> response = await _myrepo.fetchDailyClassReport(
          1, _limit, context);
      _dcrList.addAll(response['classReport']);
      if (response['classReport'] != []) {
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadMore(BuildContext context) async {
    try {
      final Map<String, dynamic> response = await _myrepo.fetchDailyClassReport( _currentPage, _limit, context);
      if (response['classReport']!=[]) {
        _dcrList.addAll(response['classReport']);
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }
}
