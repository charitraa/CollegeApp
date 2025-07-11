import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../data/api_response.dart';
import '../../model/event_model.dart';
import '../../repository/calender_repository/calender_repository.dart';

class EventCalenderViewModel with ChangeNotifier {
  final CalendarRepository _myrepo = CalendarRepository();
  final List<EventModel> _events = [];
  List<EventModel> get events => _events;
  final List<EventModel> _monthlyEvents = [];
  List<EventModel> get monthlyEvents => _monthlyEvents;

  ApiResponse<List<EventModel>> userData = ApiResponse.loading();
  ApiResponse<EventModel> appDetails = ApiResponse.loading();
  EventModel? get currentDetails => appDetails.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final _logger = Logger();

  void setDetails(ApiResponse<EventModel> response) {
    _logger.i('Setting Event details: ${response.status}');
    appDetails = response;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> fetchMonthly(
      String filter, String date, String? type, BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      final Map<String, dynamic> response = await _myrepo.fetchEventCalendar(
        filter: filter,
        date: date,
        type: (type != null && type.isNotEmpty) ? type : null,
        context: context,
      );
      _events.clear();
      _events.addAll(response['calendar']);
      userData = ApiResponse.completed(_events);
    } catch (error) {
      userData = ApiResponse.error("Unexpected error: $error");
    } finally {
      setLoading(false);
    }
  }
  Future<void> fetchDaily(
      String filter, String date, String? type, BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      final Map<String, dynamic> response = await _myrepo.fetchEventCalendar(
        filter: filter,
        date: date,
        type: (type != null && type.isNotEmpty) ? type : null,
        context: context,
      );

      _monthlyEvents.clear();
      _monthlyEvents.addAll(response['calendar']);
      userData = ApiResponse.completed(_monthlyEvents);
    } catch (error) {
      userData = ApiResponse.error("Unexpected error: $error");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getApplicationDetails(
      String eventId, BuildContext context) async {
    if (_isLoading) {
      _logger.w('Fetch already in progress. Ignoring duplicate call.');
      return;
    }
    setLoading(true);
    try {
      final EventModel dcr = await _myrepo.eventModel(eventId, context);
      if (dcr != null) {
        _logger.i('Event details fetched successfully');
        setDetails(ApiResponse.completed(dcr));
      } else {
        _logger.w('No Event details available');
        setDetails(ApiResponse.error('No data available'));
      }
    } catch (error, stackTrace) {
      _logger.e('Error fetching Event details',
          error: error, stackTrace: stackTrace);
      setDetails(ApiResponse.error('Error fetching data: $error'));
    } finally {
      setLoading(false);
    }
  }
}
