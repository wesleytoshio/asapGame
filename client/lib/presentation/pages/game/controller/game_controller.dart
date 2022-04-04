import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'game_controller.g.dart';

enum GameState {
  none,
  ready,
  timeleft,
  interval,
  finish,
}

@lazySingleton
class GameController = _GameControllerBase with _$GameController;

abstract class _GameControllerBase with Store {
  @observable
  int timeleft = 10;

  @observable
  GameState state = GameState.none;

  @observable
  bool shiftEnded = true;

  @observable
  bool soundOn = true;

  @observable
  Timer? _timer;

  @action
  startTimeLeft({Duration duration = const Duration(seconds: 1)}) {
    shiftEnded = false;
    cancelTimeLeft();
    state = GameState.timeleft;
    timeleft = 30;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (timeleft == 0) {
          state = GameState.interval;
          timer.cancel();
          startInterval();
        } else {
          timeleft--;
        }
      },
    );
  }

  @action
  startInterval({Duration duration = const Duration(seconds: 1)}) {
    shiftEnded = false;
    cancelTimeLeft();
    state = GameState.interval;
    timeleft = 10;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (timeleft == 0) {
          state = GameState.none;
          startTimeLeft();
          timer.cancel();
        } else {
          timeleft--;
        }
      },
    );
  }

  @action
  cancelTimeLeft() {
    _timer?.cancel();
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
