// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameController on _GameControllerBase, Store {
  final _$stopwatchAtom = Atom(name: '_GameControllerBase.stopwatch');

  @override
  int get stopwatch {
    _$stopwatchAtom.reportRead();
    return super.stopwatch;
  }

  @override
  set stopwatch(int value) {
    _$stopwatchAtom.reportWrite(value, super.stopwatch, () {
      super.stopwatch = value;
    });
  }

  final _$currentRoundAtom = Atom(name: '_GameControllerBase.currentRound');

  @override
  RoundEntity get currentRound {
    _$currentRoundAtom.reportRead();
    return super.currentRound;
  }

  @override
  set currentRound(RoundEntity value) {
    _$currentRoundAtom.reportWrite(value, super.currentRound, () {
      super.currentRound = value;
    });
  }

  final _$shiftEndedAtom = Atom(name: '_GameControllerBase.shiftEnded');

  @override
  bool get shiftEnded {
    _$shiftEndedAtom.reportRead();
    return super.shiftEnded;
  }

  @override
  set shiftEnded(bool value) {
    _$shiftEndedAtom.reportWrite(value, super.shiftEnded, () {
      super.shiftEnded = value;
    });
  }

  final _$soundOnAtom = Atom(name: '_GameControllerBase.soundOn');

  @override
  bool get soundOn {
    _$soundOnAtom.reportRead();
    return super.soundOn;
  }

  @override
  set soundOn(bool value) {
    _$soundOnAtom.reportWrite(value, super.soundOn, () {
      super.soundOn = value;
    });
  }

  final _$answersAtom = Atom(name: '_GameControllerBase.answers');

  @override
  ObservableList<dynamic> get answers {
    _$answersAtom.reportRead();
    return super.answers;
  }

  @override
  set answers(ObservableList<dynamic> value) {
    _$answersAtom.reportWrite(value, super.answers, () {
      super.answers = value;
    });
  }

  final _$_timerAtom = Atom(name: '_GameControllerBase._timer');

  @override
  Timer? get _timer {
    _$_timerAtom.reportRead();
    return super._timer;
  }

  @override
  set _timer(Timer? value) {
    _$_timerAtom.reportWrite(value, super._timer, () {
      super._timer = value;
    });
  }

  final _$startTimeLeftAsyncAction =
      AsyncAction('_GameControllerBase.startTimeLeft');

  @override
  Future startTimeLeft({int duration = 20}) {
    return _$startTimeLeftAsyncAction
        .run(() => super.startTimeLeft(duration: duration));
  }

  final _$stopwatchPlayersAsyncAction =
      AsyncAction('_GameControllerBase.stopwatchPlayers');

  @override
  Future stopwatchPlayers({int duration = 5}) {
    return _$stopwatchPlayersAsyncAction
        .run(() => super.stopwatchPlayers(duration: duration));
  }

  final _$_GameControllerBaseActionController =
      ActionController(name: '_GameControllerBase');

  @override
  dynamic startInterval({Duration duration = const Duration(seconds: 1)}) {
    final _$actionInfo = _$_GameControllerBaseActionController.startAction(
        name: '_GameControllerBase.startInterval');
    try {
      return super.startInterval(duration: duration);
    } finally {
      _$_GameControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic saveAnswer(dynamic value) {
    final _$actionInfo = _$_GameControllerBaseActionController.startAction(
        name: '_GameControllerBase.saveAnswer');
    try {
      return super.saveAnswer(value);
    } finally {
      _$_GameControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic send() {
    final _$actionInfo = _$_GameControllerBaseActionController.startAction(
        name: '_GameControllerBase.send');
    try {
      return super.send();
    } finally {
      _$_GameControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSound() {
    final _$actionInfo = _$_GameControllerBaseActionController.startAction(
        name: '_GameControllerBase.setSound');
    try {
      return super.setSound();
    } finally {
      _$_GameControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stopwatch: ${stopwatch},
currentRound: ${currentRound},
shiftEnded: ${shiftEnded},
soundOn: ${soundOn},
answers: ${answers}
    ''';
  }
}
