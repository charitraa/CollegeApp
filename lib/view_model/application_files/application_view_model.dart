import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/repository/application_repository/application_repository.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class ApplicationViewModel with ChangeNotifier {
  final ApplicationRepository _myrepo = ApplicationRepository();
  //todo: Change model name based on that u wanna display
  final List<UserModel> _applications = [];
  int _currentPage = 1;
  int _limit = 10;
  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserModel> get applications => _applications;

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
      _applications.clear();
      final Map<String, dynamic> response =
          await _myrepo.fetchApplications(1, _limit, context);
      _applications.addAll(response['applications']);
      if (response['applications'] != []) {
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadMore( BuildContext context) async {
    try {
      final Map<String, dynamic> response =
          await _myrepo.fetchApplications(_currentPage, _limit, context);
      if (response['applications'] != []) {
        _applications.addAll(response['applications']);
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }

  Future<bool> createApplication(
      dynamic data, File file, BuildContext context) async {
    try {
      final response = await _myrepo.createApplication(data, file, context);
      if (response != null) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
      return false;
    }
  }
  Future<bool> updateApplication(
      dynamic data, File file, BuildContext context) async {
    try {
      final response = await _myrepo.updateApplication(data, file, context);
      if (response != null) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
      return false;
    }
  }
}
