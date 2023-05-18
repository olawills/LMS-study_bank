import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/constants/custom_text_style.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/result_controller/result_controller.dart';
import 'package:study_bank/mobileLayout/widgets/answers_card/answer_card.dart';
import 'package:study_bank/mobileLayout/widgets/components/answers_output_card.dart';
import 'package:study_bank/mobileLayout/widgets/components/content_area.dart';
import 'package:study_bank/mobileLayout/widgets/components/custom_app_bar.dart';
import 'package:study_bank/mobileLayout/widgets/components/main_buttons.dart';
import 'package:study_bank/mobileLayout/widgets/components/question_widget.dart';
import 'package:study_bank/screens/result_screen/check_result_screen.dart';

class ResultScreen extends GetView<QuestionController> {
  static const String routeName = '/result_screen';
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          leading: const SizedBox(height: 40),
          title: controller.correctAnsweredQuestions,
        ),
        body: QuestionDecorationWidget(
          child: Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/bulb.svg',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          'Congratulations',
                          style: headerText.copyWith(
                            color: textColor,
                          ),
                        ),
                      ),
                      Text(
                        'You have ${controller.eachPoints} points',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Tap below question numbers to view correct answers',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      Expanded(
                        child: GridView.builder(
                            itemCount: controller.allQuestions.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.width ~/ 75,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (_, index) {
                              final question = controller.allQuestions[index];
                              AnswerStatus status = AnswerStatus.notanswered;
                              final selectedAnswer = question.selectedAnswer;
                              final correctAnswer = question.correctAnswer;
                              if (selectedAnswer == correctAnswer) {
                                status = AnswerStatus.correct;
                              } else if (question.selectedAnswer == null) {
                                status = AnswerStatus.wrong;
                              } else {
                                status = AnswerStatus.wrong;
                              }
                              return AnswerOutputCard(
                                onTap: () {
                                  controller.jumpToQuestion(index,
                                      isGoBack: false);
                                  Get.toNamed(CheckResultScreen.routeName);
                                },
                                index: index + 1,
                                status: status,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIInterface.mobileScreenPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            controller.tryAgain();
                          },
                          color: Colors.blueGrey,
                          title: 'Try Again',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            controller.saveTestResult();
                          },
                          title: 'Go home',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
