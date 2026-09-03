import 'package:http/http.dart' as http;

class BackendBootstrap {
  static Future<bool> validate(
    String baseUrl, {
    http.Client? client,
    Duration timeout = const Duration(seconds: 2),
  }) async {
    final http.Client activeClient = client ?? http.Client();
    try {
      final response = await activeClient
          .get(Uri.parse('$baseUrl/ping'))
          .timeout(timeout);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    } finally {
      if (client == null) {
        activeClient.close();
      }
    }
  }
}
