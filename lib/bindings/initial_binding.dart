import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/authControllers/auth_controller.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper_controller.dart';
import 'package:study_bank/mobileLayout/controllers/theme_controller.dart';
import 'package:study_bank/services/firebase_service_storage.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.put(QuestionPaperController());
    Get.lazyPut(() => FirebaseStorageService());
  }
}
