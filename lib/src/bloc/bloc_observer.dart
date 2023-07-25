import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_magic_ball/src/utils/error_handlers/error_util.dart';

class AppBlocObserver extends BlocObserver {
  static AppBlocObserver? _singleton;

  AppBlocObserver._();

  factory AppBlocObserver.instance() => _singleton ??= AppBlocObserver._();

  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
    debugPrint('${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event == null) return;
    debugPrint('${bloc.runtimeType}.add(${event.runtimeType})');
    final state = bloc.state;
    if (state == null) return;
  }

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    final Object? event = transition.event;
    final Object? currentState = transition.currentState;
    final Object? nextState = transition.nextState;
    if (event == null || currentState == null || nextState == null) return;
    debugPrint(
      '${bloc.runtimeType} ${event.runtimeType}: ${currentState.runtimeType}->${nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('$error');
    debugPrint('$stackTrace');
    ErrorUtil.logError(
      error,
      stackTrace: stackTrace,
      hint: 'BLoC: ${bloc.runtimeType}',
    );
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
    debugPrint('${bloc.runtimeType}.close()');
  }
}
