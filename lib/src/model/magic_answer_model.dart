class MagicAnswerModel {
  final String answer;

  const MagicAnswerModel({
    required this.answer,
  });

  factory MagicAnswerModel.fromJson(Map<String, dynamic> json) =>
      MagicAnswerModel(
        answer: json['reading'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagicAnswerModel &&
          runtimeType == other.runtimeType &&
          answer == other.answer;

  @override
  int get hashCode => answer.hashCode;
}
