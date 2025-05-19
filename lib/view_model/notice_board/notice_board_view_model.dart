import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/repository/notice_board/notice_board_repository.dart';
import '../../data/api_response.dart';
import '../../utils/utils.dart';

class NoticeBoardViewModel with ChangeNotifier {
  final NoticeBoardRepository _myrepo = NoticeBoardRepository();
  //todo: Change model name based on that u wanna display
  final List<UserModel> _notices = [];
  int _currentPage = 1;
  int _limit = 10;
  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;
  bool _isLoading = false;
  String _searchValue = '';
  String get searchValue => _searchValue;
  bool get isLoading => _isLoading;
  List<UserModel> get notices => _notices;

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
      _notices.clear();
      final Map<String, dynamic> response = await _myrepo.fetchNotices(
          1, _limit, context);
      _notices.addAll(response['notices']);
      if (response['notices'] != []) {
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching notices: $error", context);
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadMore(BuildContext context) async {
    try {
      final Map<String, dynamic> response = await _myrepo.fetchNotices( _currentPage, _limit, context);
      if (response['notices']!=[]) {
        _notices.addAll(response['notices']);
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }
}
