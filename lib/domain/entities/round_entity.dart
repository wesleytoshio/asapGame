import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';

class RoundEntity {
  final GameStage stage;
  final int stopwatch;
  final dynamic answer;
  final bool? heResponded;
  RoundEntity({
    this.stage = GameStage.none,
    this.stopwatch = 0,
    this.heResponded,
    this.answer,
  });

  copyWith({
    GameStage? stage,
    int? stopwatch,
    bool? heResponded,
    String? answer,
  }) {
    return RoundEntity(
      stage: stage ?? this.stage,
      answer: answer ?? this.answer,
      stopwatch: stopwatch ?? this.stopwatch,
      heResponded: heResponded ?? this.heResponded,
    );
  }
}
