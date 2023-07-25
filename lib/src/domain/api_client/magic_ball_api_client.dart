import 'package:dio/dio.dart';
import 'package:surf_practice_magic_ball/src/model/magic_answer_model.dart';
import 'package:surf_practice_magic_ball/src/utils/exceptions/magic_exception.dart';

class MagicBallApiClient implements IMagicBallApiClient {
  final Dio _client;

  const MagicBallApiClient({
    required Dio client,
  }) : _client = client;

  @override
  Future<MagicAnswerModel> askMagicBall() async {
    try {
      final response = await _client.get<Map<String, dynamic>>('/api');
      final data = response.data;
      if (data == null) {
        throw const MagicException(
          message: 'Null response returned',
          type: MagicExceptionType.empty,
        );
      }
      final result = MagicAnswerModel.fromJson(data);

      return result;
    } on Object {
      rethrow;
    }
  }
}

abstract interface class IMagicBallApiClient {
  Future<MagicAnswerModel> askMagicBall();
}
