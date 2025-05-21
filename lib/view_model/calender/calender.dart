import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/repository/calender_repository/calender_repository.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class CalenderViewModel with ChangeNotifier {
  final CalenderRepository _myrepo = CalenderRepository();
  //todo: Change model name based on that u wanna display
  final List<UserModel> _calenderList = [];
  int _currentPage = 1;
  int _limit = 10;
  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserModel> get calenderList => _calenderList;

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
      _calenderList.clear();
      final Map<String, dynamic> response =
          await _myrepo.fetchCalender(context);
      if (response['calender'] != [] || response['calender'] != null) {
        _calenderList.addAll(response['calender']);
      }
      // if (response['calender'] != []) {
      //   _currentPage++;
      // }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    } finally {
      setLoading(false);
    }
  }
}
