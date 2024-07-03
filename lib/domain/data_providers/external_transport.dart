import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<Map<String, String>> checkLatestRelease(bool isAndroid) async {
  String url = 'https://api.github.com/repos/OpenRbt/mobile-wash-control/releases/latest';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final latestVersion = jsonResponse['tag_name'];

    String downloadUrl = '';
    if(isAndroid) downloadUrl = jsonResponse['assets'][0]['browser_download_url'];
    else downloadUrl = jsonResponse['assets'][1]['browser_download_url'];

    return {
      'latestVersion': latestVersion,
      'downloadUrl': downloadUrl
    };

  } else {
    throw Exception('statusCode != 200');
  }
}

Future<void> downloadFile(String url, String filename) async {
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String dir = (await getExternalStorageDirectory())?.path ?? '';
      File file = File('$dir/$filename');
      await file.writeAsBytes(response.bodyBytes);
      print("$file Downloaded");
    } else {
      print("${'failed_to_download_the_file'.tr()}: ${response.statusCode}");
    }
  } catch (e) {
    print("${'failed_to_download_the_file'.tr()}: $e");
  }
}