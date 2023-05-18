import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/authControllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();
  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLoginScreen();
  }

  void showProfileInfo() {
    _launch('https://www.github.com/olawills/study_bank');
  }

  void showGitAccount() {
    _launch('https://www.github.com/olawills');
  }

  void sendEmail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: ' wobdele@gmail.com',
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'couldnot launch $url';
    }
  }
}
