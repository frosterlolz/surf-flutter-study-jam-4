import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_magic_ball/src/bloc/bloc_observer.dart';
import 'package:surf_practice_magic_ball/src/domain/api_client/magic_ball_api_client.dart';
import 'package:surf_practice_magic_ball/src/domain/repositories/magic_repository.dart';
import 'package:surf_practice_magic_ball/src/features/magic_ball/bloc/magic_ball_bloc.dart';
import 'package:surf_practice_magic_ball/src/features/magic_ball/view/magic_ball_screen.dart';
import 'package:surf_practice_magic_ball/src/utils/error_handlers/default_error_handler.dart';

void main() async {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppBlocObserver.instance();
    Bloc.transformer = sequential<Object?>();

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
    /// Advanced DIContainer :D
    final errorHandler = DefaultErrorHandler();
    final client = Dio()..options.baseUrl = 'https://eightballapi.com/api';
    final magicBallApiClient = MagicBallApiClient(
      client: client,
    );
    final magicBallRepository = MagicRepository(
      magicBallApiClient: magicBallApiClient,
    );

    return BlocProvider(
      create: (context) => MagicBallBloc(
        errorHandler: errorHandler,
        magicBallRepository: magicBallRepository,
      ),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MagicBallScreen(),
      ),
    );
  }
}
