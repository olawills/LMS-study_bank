import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/mobileLayout/controllers/authControllers/auth_controller.dart';
import 'package:study_bank/mobileLayout/widgets/components/main_buttons.dart';

class LoginScreen extends GetView<AuthController> {
  static const String routeName = '/login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_splash_logo.png',
              width: 200,
              height: 200,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Text(
                'Welcome To Study Bank ELearning App, Get latest Questions and Answers from our app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MainButton(
              onTap: () {
                controller.signInWithGoogle();
              },
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      'assets/icons/google.svg',
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
