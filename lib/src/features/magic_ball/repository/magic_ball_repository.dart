import 'package:surf_practice_magic_ball/src/model/magic_answer_model.dart';

abstract interface class IMagicBallRepository {
  Future<MagicAnswerModel> magicAnswer();
}
