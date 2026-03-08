class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'AppException(message: $message, statusCode: $statusCode)';
}

class ServerException extends AppException {
  ServerException({
    required super.message,
    super.statusCode,
  });
}

class NetworkException extends AppException {
  NetworkException({
    required super.message,
    super.statusCode,
  });
}

class UnauthorizedException extends AppException {
  UnauthorizedException({
    required super.message,
    super.statusCode,
  });
}

class ParsingException extends AppException {
  ParsingException({
    required super.message,
    super.statusCode,
  });
}