import 'package:shared_preferences/shared_preferences.dart';

/// Remembers the wash server the operator connected to last, so a restart does
/// not force a full subnet scan before the app is usable again.
class BackendHostStore {
  static const String _hostKey = 'BackendHost';

  static Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final host = prefs.getString(_hostKey);
    if (host == null || host.trim().isEmpty) {
      return null;
    }
    return host;
  }

  static Future<void> save(String host) async {
    final trimmed = host.trim();
    if (trimmed.isEmpty) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_hostKey, trimmed);
  }
}
