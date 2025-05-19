import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/repository/download_forms/download_forums_repository.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class DownloadFormViewModel with ChangeNotifier {
  final DownloadForumsRepository _myrepo = DownloadForumsRepository();
  //todo: Change model name based on that u wanna display
  final List<UserModel> _downloadForms = [];
  int _currentPage = 1;
  int _limit = 10;
  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserModel> get downloadForms => _downloadForms;

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
      _downloadForms.clear();
      final Map<String, dynamic> response = await _myrepo.getDocuments(
          1, _limit, context);
      _downloadForms.addAll(response['forms']);
      if (response['forms'] != []) {
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
      final Map<String, dynamic> response = await _myrepo.getDocuments( _currentPage, _limit, context);
      if (response['forms']!=[]) {
        _downloadForms.addAll(response['forms']);
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }
}
