import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/repository/class_routine_repository/class_routine_repository.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class ClassRoutineViewModel with ChangeNotifier {
  final ClassRoutineRepository _myrepo = ClassRoutineRepository();
  //todo: Change model name based on that u wanna display
  final List<UserModel> _routines = [];
  int _currentPage = 1;
  int _limit = 10;
  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserModel> get routines => _routines;

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
      _routines.clear();
      final Map<String, dynamic> response = await _myrepo.fetchClassRoutine(
          1, _limit, context);
      _routines.addAll(response['classRoutine']);
      if (response['classRoutine'] != []) {
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
      final Map<String, dynamic> response = await _myrepo.fetchClassRoutine( _currentPage, _limit, context);
      if (response['forms']!=[]) {
        _routines.addAll(response['classRoutine']);
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }
}
