import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper_controller.dart';
import 'package:study_bank/mobileLayout/controllers/zoom_controller/zoom_controller.dart';
import 'package:study_bank/screens/home_screen/home_screen.dart';
import 'package:study_bank/screens/login/login_screen.dart';
import 'package:study_bank/screens/question_screen/question_screen.dart';
import 'package:study_bank/screens/result_screen/check_result_screen.dart';
import 'package:study_bank/screens/result_screen/result_screen.dart';
import 'package:study_bank/screens/splash_screens/intro_screen.dart';
import 'package:study_bank/screens/splash_screens/splash_screen.dart';
import 'package:study_bank/screens/test_overview_screen/test_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: "/introduction",
          page: () => const IntroScreen(),
        ),
        GetPage(
          name: '/home_screen',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuestionPaperController());
            Get.put(MyZoomDrawerController());
          }),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: QuestionScreen.routeName,
          page: () => const QuestionScreen(),
          binding: BindingsBuilder(
            () {
              Get.put<QuestionController>(QuestionController());
            },
          ),
        ),
        GetPage(
          name: TestScreen.routeName,
          page: () => const TestScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: CheckResultScreen.routeName,
          page: () => const CheckResultScreen(),
        ),
      ];
}
