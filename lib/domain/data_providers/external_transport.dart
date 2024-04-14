import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<Map<String, String>> checkLatestRelease() async {
  var url = 'https://api.github.com/repos/OpenRbt/mobile-wash-control/releases/latest';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    var latestVersion = jsonResponse['tag_name'];

    var downloadUrl = jsonResponse['assets'][0]['browser_download_url'];

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
      print("Ошибка при загрузке файла: ${response.statusCode}");
    }
  } catch (e) {
    print("Ошибка при загрузке файла: $e");
  }
}