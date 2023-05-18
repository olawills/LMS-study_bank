import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/authControllers/auth_controller.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/firebase_refer.dart';
import 'package:study_bank/models/question_paper_model.dart';
import 'package:study_bank/screens/question_screen/question_screen.dart';
import 'package:study_bank/services/firebase_service_storage.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = [
      "biology",
      "chemistry",
      "maths",
      "physiics",
    ];
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await questionPaperReference.get();

      final paperList =
          data.docs.map((paper) => QuestionModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);
      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }

      allPapers.assignAll(paperList);
    } catch (e) {
      log(e.toString());
    }
  }

  void navigateToQuestions(
      {required QuestionModel paper, bool tryAgain = false}) {
    AuthController authController = Get.find();
    if (authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(
          QuestionScreen.routeName,
          arguments: paper,
          preventDuplicates: false,
        );
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      authController.showLoginAlertDialog();
    }
  }
}
