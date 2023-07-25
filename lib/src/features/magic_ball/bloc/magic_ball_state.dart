part of 'magic_ball_bloc.dart';

@immutable
sealed class MagicBallState {
  MagicAnswerModel? get magicAnswer;

  const MagicBallState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagicBallState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

final class MagicBallState$Initial extends MagicBallState {
  @override
  MagicAnswerModel? get magicAnswer => null;

  const MagicBallState$Initial();
}

final class MagicBallState$InProgress extends MagicBallState {
  @override
  final MagicAnswerModel? magicAnswer;

  const MagicBallState$InProgress({required this.magicAnswer});
}

final class MagicBallState$Success extends MagicBallState {
  @override
  final MagicAnswerModel magicAnswer;

  const MagicBallState$Success({required this.magicAnswer});
}

final class MagicBallState$Failure extends MagicBallState {
  @override
  final MagicAnswerModel? magicAnswer;
  final String message;

  const MagicBallState$Failure({
    required this.magicAnswer,
    required this.message,
  });
}
