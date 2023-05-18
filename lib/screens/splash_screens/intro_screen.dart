import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/mobileLayout/widgets/app_buttons/app_circle_buttons.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 65,
              ),
              const SizedBox(height: 40),
              const Text(
                "Welcome To LMS Study App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              AppCircleButtons(
                onTap: () => Get.offAndToNamed("/home_screen"),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
