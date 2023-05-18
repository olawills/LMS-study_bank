import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/firebase_refer.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/loading_status.dart';
import 'package:study_bank/models/question_paper_model.dart';

class DataUploads extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs; //loading is obs

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;

    final uploadToFirestore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final questions = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();
    List<QuestionModel> questionmodel = [];
    for (var paper in questions) {
      String paperContent = await rootBundle.loadString(paper);
      questionmodel.add(QuestionModel.fromJson(json.decode(paperContent)));
    }

    // print('Items number ${questionmodel[0].description}');
    var batch = uploadToFirestore.batch();

    for (var paper in questionmodel) {
      batch.set(questionPaperReference.doc(paper.id), {
        "id": paper.id,
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count":
            paper.questions == null ? 0 : paper.questions!.length,
      });

      for (var questions in paper.questions!) {
        final questionsPath = questionReference(
          paperId: paper.id,
          questionId: questions.id,
        );
        batch.set(questionsPath, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer,
        });
        for (var answers in questions.answers) {
          batch.set(
              questionsPath.collection("answers").doc(answers.identifier), {
            "identifier": answers.identifier,
            "answer": answers.answer,
          });
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
