import 'package:flutter/material.dart';
import 'package:study_bank/configs/themes/sub_theme_mixin.dart';

const Color primaryDarkColor = Color(0xff2e3c62);

const Color primaryColorDark = Color(0xff99ace1);
const Color mainTextColorDark = Colors.white;

class Darktheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTextThemes().apply(
        bodyColor: mainTextColorDark,
        displayColor: mainTextColorDark,
      ),
    );
  }
}
