// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  final _$userAtom = Atom(name: '_AppControllerBase.user');

  @override
  UserEntity? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$themeDataAtom = Atom(name: '_AppControllerBase.themeData');

  @override
  ThemeData? get themeData {
    _$themeDataAtom.reportRead();
    return super.themeData;
  }

  @override
  set themeData(ThemeData? value) {
    _$themeDataAtom.reportWrite(value, super.themeData, () {
      super.themeData = value;
    });
  }

  final _$initializeAppAsyncAction =
      AsyncAction('_AppControllerBase.initializeApp');

  @override
  Future initializeApp() {
    return _$initializeAppAsyncAction.run(() => super.initializeApp());
  }

  final _$loggedOutAsyncAction = AsyncAction('_AppControllerBase.loggedOut');

  @override
  Future loggedOut() {
    return _$loggedOutAsyncAction.run(() => super.loggedOut());
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  dynamic setUser(UserEntity value) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setThemeData(ThemeData value) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.setThemeData');
    try {
      return super.setThemeData(value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
themeData: ${themeData}
    ''';
  }
}
