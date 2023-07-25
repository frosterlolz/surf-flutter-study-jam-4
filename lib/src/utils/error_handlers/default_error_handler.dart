import 'package:surf_practice_magic_ball/src/utils/error_handlers/error_handler.dart';
import 'package:surf_practice_magic_ball/src/utils/helpers/logger.dart';

class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object error, {StackTrace? stackTrace}) {
    logger.d(stackTrace, error);
  }
}

/*
logger.v("Verbose log");

logger.d("Debug log");

logger.i("Info log");

logger.w("Warning log");

logger.e("Error log");

logger.wtf("What a terrible failure log");
 */
