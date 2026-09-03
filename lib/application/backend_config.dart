class BackendConfig {
  static const int defaultPort = 8020;
  static const String _apiBaseUrl = String.fromEnvironment('api_base_url');

  static String get defaultScanHost => 'localhost';

  static String get webBaseUrl {
    if (_apiBaseUrl.trim().isNotEmpty) {
      return normalizeBaseUrl(_apiBaseUrl);
    }

    final host = Uri.base.host.isEmpty ? defaultScanHost : Uri.base.host;
    final scheme = Uri.base.scheme == 'https' ? 'https' : 'http';
    return '$scheme://$host:$defaultPort';
  }

  static String baseUrlForHost(String host) {
    final trimmed = host.trim();
    if (trimmed.isEmpty) {
      return 'http://$defaultScanHost:$defaultPort';
    }
    return normalizeBaseUrl(trimmed);
  }

  static String normalizeBaseUrl(String value) {
    var normalized = value.trim();
    if (normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }

    if (normalized.contains('://')) {
      return normalized;
    }

    final uri = Uri.tryParse('http://$normalized');
    if (uri != null && uri.hasPort) {
      return 'http://$normalized';
    }
    return 'http://$normalized:$defaultPort';
  }
}
