import 'package:flutter/material.dart';
import 'package:lbef/model/sms_model.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';
import '../../repository/notice_board/notice_board_repository.dart';

class SmsViewModel with ChangeNotifier {
  final NoticeBoardRepository _myrepo = NoticeBoardRepository();
  final List<SmsModel> _notices = [];
  List<SmsModel>? get notices => _notices;
  ApiResponse<SmsModel> userData = ApiResponse.loading();

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  final _logger = Logger();
  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> fetch(BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      final Map<String, dynamic> response =
      await _myrepo.fetchSms(context);
      _notices.addAll(response['notices']);
      notifyListeners();
    } catch (error) {
      userData = ApiResponse.error("Unexpected error: $error");
    } finally {
      setLoading(false);
    }
  }
}
