import 'dart:async';

import 'package:http/http.dart' as http;

/// Wraps an [http.Client] so a request cannot hang forever.
///
/// The generated OpenAPI clients build a bare `http.Client()`, which has no timeout
/// at all: an unreachable or wedged wash server left every call pending, and the 1.5s
/// status poller kept stacking new ones on top.
class TimeoutClient extends http.BaseClient {
  TimeoutClient({http.Client? inner, this.timeout = const Duration(seconds: 15)})
    : _inner = inner ?? http.Client();

  final http.Client _inner;

  /// Applied both to the response headers and, as an idle timeout, to the body stream.
  final Duration timeout;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _inner.send(request).timeout(timeout);
    return http.StreamedResponse(
      response.stream.timeout(timeout),
      response.statusCode,
      contentLength: response.contentLength,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
