class HttpStatus {
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;
  static const int noContent = 204;
}

class SocketException implements Exception {
  const SocketException([this.message = '']);

  final String message;
}

class TlsException implements Exception {
  const TlsException([this.message = '']);

  final String message;
}

class IOException implements Exception {
  const IOException([this.message = '']);

  final String message;
}
