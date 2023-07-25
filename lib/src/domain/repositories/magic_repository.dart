import 'package:surf_practice_magic_ball/src/domain/api_client/magic_ball_api_client.dart';
import 'package:surf_practice_magic_ball/src/features/magic_ball/repository/magic_ball_repository.dart';
import 'package:surf_practice_magic_ball/src/model/magic_answer_model.dart';

class MagicRepository implements IMagicBallRepository {
  final IMagicBallApiClient _magicBallApiClient;

  const MagicRepository({
    required IMagicBallApiClient magicBallApiClient,
  }) : _magicBallApiClient = magicBallApiClient;

  @override
  Future<MagicAnswerModel> magicAnswer() async {
    try {
      final magicAnswer = await _magicBallApiClient.askMagicBall();

      return magicAnswer;
    } on Object {
      rethrow;
    }
  }
}
