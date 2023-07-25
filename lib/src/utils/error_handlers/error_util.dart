import 'package:flutter/foundation.dart';

abstract class ErrorUtil {
  ErrorUtil._();

  static void logError(
    Object exception, {
    StackTrace? stackTrace,
    String? hint,
  }) {
    try {
      if (exception is String) {
        return logMessage(
          exception,
          stackTrace: stackTrace,
          hint: hint,
          warning: true,
        );
      }
      debugPrint('$exception ${stackTrace ?? StackTrace.current}');
    } on Object catch (error, stackTrace) {
      debugPrint(
        '${'Произошло исключение "$error" в ErrorUtil.logError'} $stackTrace',
      );
    }
  }

  static void logMessage(
    String message, {
    StackTrace? stackTrace,
    String? hint,
    bool warning = false,
    List<String>? params,
  }) {
    try {
      debugPrint('$debugPrint | $stackTrace');
    } on Object catch (error, stackTrace) {
      debugPrint(
        'Произошло исключение "$error" в ErrorUtil.logMessage | $stackTrace',
      );
    }
  }
}
