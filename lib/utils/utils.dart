import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  final DateFormat formatter = DateFormat('d MMMM yyyy HH:mm', 'ru_RU');
  return formatter.format(dateTime);
}