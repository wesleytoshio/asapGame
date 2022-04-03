// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameController on _GameControllerBase, Store {
  final _$timeleftAtom = Atom(name: '_GameControllerBase.timeleft');

  @override
  int get timeleft {
    _$timeleftAtom.reportRead();
    return super.timeleft;
  }

  @override
  set timeleft(int value) {
    _$timeleftAtom.reportWrite(value, super.timeleft, () {
      super.timeleft = value;
    });
  }

  final _$stateAtom = Atom(name: '_GameControllerBase.state');

  @override
  GameState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(GameState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
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

  final _$_GameControllerBaseActionController =
      ActionController(name: '_GameControllerBase');

  @override
  dynamic startTimeLeft({Duration duration = const Duration(seconds: 1)}) {
    final _$actionInfo = _$_GameControllerBaseActionController.startAction(
        name: '_GameControllerBase.startTimeLeft');
    try {
      return super.startTimeLeft(duration: duration);
    } finally {
      _$_GameControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic cancelTimeLeft() {
    final _$actionInfo = _$_GameControllerBaseActionController.startAction(
        name: '_GameControllerBase.cancelTimeLeft');
    try {
      return super.cancelTimeLeft();
    } finally {
      _$_GameControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
timeleft: ${timeleft},
state: ${state},
shiftEnded: ${shiftEnded}
    ''';
  }
}
