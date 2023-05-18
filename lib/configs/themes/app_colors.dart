import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_dark_theme.dart';
import 'package:study_bank/configs/themes/app_light_theme.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';

const onSurfaceTextColor = Colors.white;

const Color correctAnswerColor = Color(0xff3ac3cb);
const Color wrongAnswerColor = Color(0xfff85187);
const Color notAnsweredColor = Color(0xff2a3c65);

const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryLightColor,
      primaryColorLight,
    ]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryDarkColor,
      primaryColorDark,
    ]);

LinearGradient mainGradient() =>
    UIInterface.isDarkMode() ? mainGradientDark : mainGradientLight;

Color customScaffoldColor(BuildContext context) => UIInterface.isDarkMode()
    ? const Color(0xff2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);

Color answerSlectedColor() => UIInterface.isDarkMode()
    ? Theme.of(Get.context!).cardColor.withOpacity(0.5)
    : Theme.of(Get.context!).primaryColor;

Color answerBorderColor() => UIInterface.isDarkMode()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);
