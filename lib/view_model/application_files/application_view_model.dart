import 'package:flutter/material.dart';
import 'package:lbef/model/application_model.dart';
import 'package:lbef/repository/application_repository/application_repository.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';

class ApplicationViewModel with ChangeNotifier {
  final ApplicationRepository _myrepo = ApplicationRepository();
  final List<ApplicationModel> _applications = [];
  List<ApplicationModel>? get applications => _applications;
  ApiResponse<ApplicationModel> userData = ApiResponse.loading();

  ApiResponse<ApplicationModel> appDetails = ApiResponse.loading();
  ApplicationModel? get currentDetails => appDetails.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setDetails(ApiResponse<ApplicationModel> response) {
    _logger.i('Setting DCR details: ${response.status}');
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
      final Map<String, dynamic> response =
          await _myrepo.fetchApplications(context);
      _applications.addAll(response['applications']);

      notifyListeners();
    } catch (error) {
      userData = ApiResponse.error("Unexpected error: $error");

    } finally {
      setLoading(false);
    }
  }

  Future<bool> createApplication(dynamic data, BuildContext context) async {
    try {
      _logger.d(data);
      final response = await _myrepo.createApplication(data, context);
      if (response != null) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateApplication(
      dynamic data, BuildContext context) async {
    try {
      final response = await _myrepo.updateApplication(data, context);
      if (response != null) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<void> getApplicationDetails(
      String applicationId, BuildContext context) async {
    if (_isLoading) {
      _logger.w('Fetch already in progress. Ignoring duplicate call.');
      return;
    }
    setLoading(true);
    try {
      final ApplicationModel dcr =
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
