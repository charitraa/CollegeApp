import 'package:intl/intl.dart';
import 'package:html_unescape/html_unescape.dart';

String parseDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('MMMM d, yyyy').format(dateTime);
}

String decodeHtmlCurrencySymbol(String rawSymbol) {
  final unescape = HtmlUnescape();
  return unescape.convert(rawSymbol);
}
