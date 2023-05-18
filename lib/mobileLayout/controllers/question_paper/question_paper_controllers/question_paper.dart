import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/firebase_refer.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/loading_status.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper_controller.dart';
import 'package:study_bank/models/question_paper_model.dart';
import 'package:study_bank/screens/home_screen/home_screen.dart';
import 'package:study_bank/screens/result_screen/result_screen.dart';

class QuestionController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionModel questionPaperModel;
  final allQuestions = <Questions>[];
  Rxn<Questions> currentQuestions = Rxn<Questions>();
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final questionPaper = Get.arguments as QuestionModel;
    //print('....onReady....');

    loadData(questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperReference
              .doc(questionPaper.id)
              .collection('questions')
              .get();

      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromFirestore(snapshot))
          .toList();

      questionPaper.questions = questions;
      for (Questions question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answeryQuery =
            await questionPaperReference
                .doc(questionPaper.id)
                .collection('questions')
                .doc(question.id)
                .collection('answers')
                .get();

        final answers = answeryQuery.docs
            .map((answer) => Answers.fromFirestore(answer))
            .toList();

        question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestions.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      //print('start timer');
      if (kDebugMode) {
        print(questionPaper.questions![0].question);
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestions.value!.selectedAnswer = answer;
    update(['answers_list', 'answer_review']);
  }

  String get completedTestQuestion {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return '$answered out of ${allQuestions.length} answered';
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestions.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestions.value = allQuestions[questionIndex.value];
  }

  void previousQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestions.value = allQuestions[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

        remainSeconds--;
      }
    });
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain() {
    Get.find<QuestionPaperController>().navigateToQuestions(
      paper: questionPaperModel,
      tryAgain: true,
    );
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}
