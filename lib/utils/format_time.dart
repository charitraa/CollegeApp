import 'package:intl/intl.dart';

String formatTimeRange(String start, String end) {
  final inputFormat = DateFormat("HH:mm:ss");
  final outputFormat = DateFormat("h:mm a");

  final startTime = inputFormat.parse(start);
  final endTime = inputFormat.parse(end);

  return "${outputFormat.format(startTime)} - ${outputFormat.format(endTime)}";
}
