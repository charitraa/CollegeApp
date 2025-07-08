import 'package:intl/intl.dart';

String parseDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('MMMM d, yyyy').format(dateTime);
}
