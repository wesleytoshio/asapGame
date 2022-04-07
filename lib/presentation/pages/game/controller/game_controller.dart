import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/entities/round_entity.dart';

part 'game_controller.g.dart';

enum GameStage {
  none,
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

  @action
  startTimeLeft({int duration = 20}) {
    shiftEnded = false;
    cancelTimeLeft();
    currentRound = RoundEntity(stage: GameStage.responding, stopwatch: 10);
    stopwatch = currentRound.stopwatch;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (stopwatch == 0) {
          startInterval();
          //cancelTimeLeft();
        } else {
          stopwatch--;
        }
      },
    );
  }

  @action
  stopwatchPlayers({int duration = 5}) {
    cancelTimeLeft();
    currentRound = RoundEntity(stage: GameStage.waiting, stopwatch: 5);
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
    shiftEnded = false;
    cancelTimeLeft();
    currentRound = RoundEntity(stage: GameStage.interval, stopwatch: 5);
    stopwatch = currentRound.stopwatch;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (stopwatch == 0) {
          startTimeLeft();
          timer.cancel();
        } else {
          stopwatch--;
        }
      },
    );
  }

  @action
  cancelTimeLeft() {
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
}
