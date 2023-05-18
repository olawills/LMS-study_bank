import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';

TextStyle cardStyle(context) => TextStyle(
      color: UIInterface.isDarkMode()
          ? Theme.of(context).textTheme.bodyLarge?.color
          : Theme.of(context).primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

const detailText = TextStyle(fontSize: 16);
const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);

const questionText = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
const appBarTs = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: onSurfaceTextColor);

TextStyle countDownTimerStyle() => TextStyle(
    letterSpacing: 2,
    color: UIInterface.isDarkMode()
        ? Theme.of(Get.context!).textTheme.bodyLarge!.color
        : Theme.of(Get.context!).primaryColor);
