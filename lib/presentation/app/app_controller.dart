import 'package:asap_game/infra/constants/storage/hive_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/user_entity.dart';
import '../themes/theme_const.dart';

part 'app_controller.g.dart';

@singleton
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  _AppControllerBase() {
    loadTheme();
  }
  @observable
  UserEntity? user;

  @observable
  ThemeData? themeData;

  @action
  setUser(UserEntity value) {
    user = value;
  }

  @action
  setThemeData(ThemeData value) {
    themeData = value.copyWith(
      // textTheme: value.textTheme.apply(
      //   fontFamily: GoogleFonts.lexend().fontFamily,
      // ),
      // appBarTheme: value.appBarTheme.copyWith(
      //   systemOverlayStyle: identical(value.brightness, Brightness.light)
      //       ? SystemUiOverlayStyle.dark
      //       : SystemUiOverlayStyle.light,
      // ),
      // primaryTextTheme: value.textTheme.apply(
      //   fontFamily: GoogleFonts.lexend().fontFamily,
      // ),
      // accentTextTheme: value.textTheme.apply(
      //   fontFamily: GoogleFonts.lexend().fontFamily,
      // ),
      colorScheme: value.colorScheme.copyWith(
        primary: const Color(primaryColor),
      ),
    );
    Hive.box(HiveBox.settings)
        .put('isDark', value.brightness == Brightness.dark);
  }

  @action
  initializeApp() {
    //setThemeData(ThemeData.light());
  }

  Future<void> loadTheme() async {
    Box settingsBox = Hive.box(HiveBox.settings);
    print(settingsBox.containsKey('isDark'));
    if (settingsBox.containsKey('isDark') && settingsBox.get('isDark')) {
      setThemeData(ThemeData.dark());
    } else {
      setThemeData(ThemeData.light());
    }
  }
}
