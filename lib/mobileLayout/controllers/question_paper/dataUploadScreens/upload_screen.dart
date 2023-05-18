import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/loading_status.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/dataUploads/uploads.dart';
// import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper.dart';

class DataUploadScreen extends StatelessWidget {
  const DataUploadScreen({Key? key}) : super(key: key);

  // QuestionController qController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    DataUploads controller = Get.put(DataUploads());
    return Scaffold(
      body: Center(
        child: Obx(
          () => Text(controller.loadingStatus.value == LoadingStatus.completed
              ? "Uploading completed"
              : "uploading.."),
        ),
      ),
    );
  }
}
