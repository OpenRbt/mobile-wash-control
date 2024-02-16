import 'package:intl/intl.dart';

String formatDateWithTime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  final DateFormat formatter = DateFormat('d MMMM yyyy HH:mm', 'ru_RU');
  return formatter.format(dateTime);
}

String formatDateWithoutTime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  final DateFormat formatter = DateFormat('d MMMM yyyy', 'ru_RU');
  return formatter.format(dateTime);
}