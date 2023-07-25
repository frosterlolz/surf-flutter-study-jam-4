import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_magic_ball/src/features/magic_ball/repository/magic_ball_repository.dart';
import 'package:surf_practice_magic_ball/src/model/magic_answer_model.dart';
import 'package:surf_practice_magic_ball/src/utils/error_handlers/error_handler.dart';
import 'package:surf_practice_magic_ball/src/utils/exceptions/magic_exception.dart';

part 'magic_ball_event.dart';
part 'magic_ball_state.dart';

class MagicBallBloc extends Bloc<MagicBallEvent, MagicBallState> {
  final ErrorHandler _errorHandler;
  final IMagicBallRepository _magicBallRepository;

  MagicBallBloc({
    required ErrorHandler errorHandler,
    required IMagicBallRepository magicBallRepository,
  })  : _errorHandler = errorHandler,
        _magicBallRepository = magicBallRepository,
        super(const MagicBallState$Initial()) {
    on<MagicBallEvent>(
      (event, emitter) => switch (event) {
        MagicBallEvent$Ask() => _askMagicBall(event, emitter),
      },
      transformer: bloc_concurrency.sequential(),
    );
  }

  Future<void> _askMagicBall(
      MagicBallEvent$Ask event, Emitter<MagicBallState> emitter) async {
    try {
      emitter(MagicBallState$InProgress(magicAnswer: state.magicAnswer));
      final answer = await _magicBallRepository.magicAnswer();
      emitter(MagicBallState$Success(magicAnswer: answer));
    } on MagicException catch (e, s) {
      _errorHandler.handleError(e, stackTrace: s);
      emitter(
        MagicBallState$Failure(
          magicAnswer: state.magicAnswer,
          message: e.message,
        ),
      );
    } on Object catch (_, __) {
      emitter(
        MagicBallState$Failure(
          magicAnswer: state.magicAnswer,
          message: 'Unhandled exception',
        ),
      );
      rethrow;
    }
  }
}
