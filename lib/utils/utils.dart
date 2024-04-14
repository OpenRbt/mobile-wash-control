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

bool versionIsGreater({required String version1, required String version2}) {
  List<String> v1 = version1.split('.');
  List<String> v2 = version2.split('.');

  for (int i = 0; i < 3; i++) {
    int num1 = int.parse(v1[i]);
    int num2 = int.parse(v2[i]);

    if (num1 > num2) {
      return true;
    } else if (num1 < num2) {
      return false;
    }
  }

  return false;
}