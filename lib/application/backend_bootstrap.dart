import 'package:http/http.dart' as http;

class BackendBootstrap {
  static Future<bool> validate(String baseUrl) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/ping'))
          .timeout(const Duration(seconds: 2));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
