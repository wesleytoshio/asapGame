import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/entities/round_content_entity.dart';
import '../../../../domain/entities/round_entity.dart';

part 'game_controller.g.dart';

enum GameStage {
  waiting,
  responding,
  interval,
  finish,
}

@lazySingleton
class GameController = _GameControllerBase with _$GameController;

abstract class _GameControllerBase with Store {
  @observable
  int stopwatch = 10;

  @observable
  RoundEntity currentRound = RoundEntity();

  @observable
  bool shiftEnded = true;

  @observable
  bool soundOn = true;

  @observable
  ObservableList answers = [].asObservable();
  @observable
  Timer? _timer;

  List<RoundContentEntity> questions = [];

  int currentStage = 0;
  int totalStage = 0;

  @action
  startTimeLeft({int duration = 20}) async {
    print('round $currentStage');
    shiftEnded = false;
    if (hasMoreRounds) {
      cancelTimer();
      currentRound = RoundEntity(
        stage: GameStage.responding,
        stopwatch: 5,
        content: questions.elementAt(currentStage),
      );

      currentStage++;
      stopwatch = currentRound.stopwatch;
      _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          if (stopwatch == 0) {
            startInterval();
          } else {
            stopwatch--;
          }
        },
      );
    }
  }

  @action
  stopwatchPlayers({int duration = 5}) async {
    cancelTimer();
    final String response = await rootBundle.loadString('assets/data.json');
    final _questions = await json.decode(response);
    for (var q in _questions) {
      questions.add(RoundContentEntity.fromMap(q));
    }
    totalStage = questions.length;
    currentRound = currentRound.copyWith(stopwatch: 5);
    stopwatch = currentRound.stopwatch;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (stopwatch == 0) {
          startTimeLeft();
        } else {
          stopwatch--;
        }
      },
    );
  }

  @action
  startInterval({Duration duration = const Duration(seconds: 1)}) {
    if (hasMoreRounds) {
      shiftEnded = false;
      cancelTimer();
      currentRound = RoundEntity(stage: GameStage.interval, stopwatch: 5);
      stopwatch = currentRound.stopwatch;

      _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          if (stopwatch == 0) {
            startTimeLeft();
          } else {
            stopwatch--;
          }
        },
      );
    } else {
      cancelTimer();
      currentRound = RoundEntity(stage: GameStage.finish, stopwatch: 5);
      //AppConfig.instance.appRouter.pop();
    }
  }

  cancelTimer() {
    _timer?.cancel();
  }

  @action
  saveAnswer(value) {
    currentRound = currentRound.copyWith(answer: value, heResponded: false);
    answers.add(value);
  }

  @action
  send() {
    print(answers);
    currentRound = currentRound.copyWith(heResponded: true);
  }

  @action
  setSound() => soundOn = !soundOn;
  Future<void> playSound(String path) async {
    if (soundOn) {
      AudioCache _playerCache =
          AudioCache(fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
      _playerCache.fixedPlayer!.setVolume(0.1);
      _playerCache.play(path);
    }
  }

  bool get hasMoreRounds => currentStage < questions.length;
}
