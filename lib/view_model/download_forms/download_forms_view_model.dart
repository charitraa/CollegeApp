import 'package:flutter/material.dart';
import 'package:lbef/model/downloadModel.dart';
import 'package:lbef/repository/download_forms/download_forums_repository.dart';
import '../../data/api_response.dart';

class DownloadFormsViewModel with ChangeNotifier {
  final DownloadForumsRepository _myrepo = DownloadForumsRepository();
  final List<DownloadModel> _downloadsList = [];

  ApiResponse<DownloadModel> userData = ApiResponse.loading();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<DownloadModel> get downloadsList => _downloadsList;

  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> fetch(BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      _downloadsList.clear();
      final Map<String, dynamic> response = await _myrepo.getDocuments(context);
      if (response['downloads']!=null) {
        _downloadsList.addAll(response['downloads'] as List<DownloadModel>);
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