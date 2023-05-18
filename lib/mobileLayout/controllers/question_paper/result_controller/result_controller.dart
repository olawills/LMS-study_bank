import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/firebase_refer.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_bank/mobileLayout/controllers/authControllers/auth_controller.dart';

extension ResultControllerExtensions on QuestionController {
  int get correctAnswerCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctAnswerCount out of ${allQuestions.length} are correct';
  }

  String get eachPoints {
    var points = (correctAnswerCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResult() async {
    var batch = firestore.batch();
    User? user = Get.find<AuthController>().getUser();
    if (user == null) return;
    batch.set(
        userRf
            .doc(user.email)
            .collection('myrecent_tests')
            .doc(questionPaperModel.id),
        {
          'points': eachPoints,
          'correct_answer': '$correctAnsweredQuestions/${allQuestions.length}',
          'question_id': questionPaperModel.id,
          'time': questionPaperModel.timeSeconds - remainSeconds
        });
    batch.commit();
    navigateToHome();
  }
}
