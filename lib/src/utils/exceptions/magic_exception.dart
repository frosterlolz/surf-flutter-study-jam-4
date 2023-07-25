class MagicException implements Exception {
  final String message;
  final MagicExceptionType type;

  const MagicException({
    required this.message,
    required this.type,
  });
}

enum MagicExceptionType {
  empty,
  other,
}
