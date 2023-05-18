import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:study_bank/configs/themes/app_dark_theme.dart';
import 'package:study_bank/configs/themes/app_light_theme.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;
  @override
  void onInit() {
    initializeThemeData();
    super.onInit();
  }

  initializeThemeData() {
    _darkTheme = Darktheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
}
