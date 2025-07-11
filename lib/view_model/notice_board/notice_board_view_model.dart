import 'package:flutter/material.dart';
import 'package:lbef/model/notice_model.dart';
import 'package:lbef/repository/notice_board/notice_board_repository.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';

class NoticeBoardViewModel with ChangeNotifier {
  final NoticeBoardRepository _myrepo = NoticeBoardRepository();
  final List<NoticeModel> _notices = [];
  List<NoticeModel>? get notices => _notices;
  ApiResponse<NoticeModel> userData = ApiResponse.loading();
  ApiResponse<NoticeModel> appDetails = ApiResponse.loading();
  NoticeModel? get currentDetails => appDetails.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setDetails(ApiResponse<NoticeModel> response) {
    _logger.i('Setting : ${response.status}');
    appDetails = response;
    notifyListeners();
  }

  final _logger = Logger();
  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> fetch(BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      _notices.clear();
      final Map<String, dynamic> response =
      await _myrepo.fetchnotices(context);
      _notices.addAll(response['notices']);
      notifyListeners();
    } catch (error) {
      userData = ApiResponse.error("Unexpected error: $error");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getNoticeDetails(
      String applicationId, BuildContext context) async {
    if (_isLoading) {
      _logger.w('Fetch already in progress. Ignoring duplicate call.');
      return;
    }
    setLoading(true);
    try {
      final NoticeModel dcr =
      await _myrepo.applicationDetails(applicationId, context);
      if (dcr != null) {
        _logger.i('DCR details fetched successfully');
        setDetails(ApiResponse.completed(dcr));
      } else {
        _logger.w('No DCR data available');
        setDetails(ApiResponse.error('No data available'));
      }
    } catch (error, stackTrace) {
      _logger.e('Error fetching DCR details',
          error: error, stackTrace: stackTrace);
      setDetails(ApiResponse.error('Error fetching data: $error'));
    } finally {
      setLoading(false);
    }
  }
}
