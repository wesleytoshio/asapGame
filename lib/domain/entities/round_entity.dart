import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';

import 'round_content_entity.dart';

class RoundEntity {
  final GameStage stage;
  final int stopwatch;
  final dynamic answer;
  final RoundContentEntity? content;
  final bool heResponded;
  RoundEntity({
    this.stage = GameStage.waiting,
    this.stopwatch = 0,
    this.heResponded = false,
    this.answer,
    this.content,
  });

  RoundEntity copyWith(
      {GameStage? stage,
      int? stopwatch,
      bool? heResponded,
      answer,
      RoundContentEntity? content}) {
    return RoundEntity(
      stage: stage ?? this.stage,
      answer: answer ?? this.answer,
      stopwatch: stopwatch ?? this.stopwatch,
      heResponded: heResponded ?? this.heResponded,
      content: content ?? this.content,
    );
  }
}
