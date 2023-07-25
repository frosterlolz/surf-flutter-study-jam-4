import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/src/features/magic_ball/view/magic_ball_screen.dart';
import 'package:surf_practice_magic_ball/src/utils/error_handlers/default_error_handler.dart';

void main() async {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const MyApp());
  }, (error, stack) {
    final sampleErrorHandler = DefaultErrorHandler();
    FlutterError.onError = (FlutterErrorDetails flutterErrorDetails) =>
        sampleErrorHandler.handleError(
          flutterErrorDetails.exception,
          stackTrace: flutterErrorDetails.stack,
        );
    sampleErrorHandler.handleError(error, stackTrace: stack);
  });
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MagicBallScreen(),
    );
  }
}
