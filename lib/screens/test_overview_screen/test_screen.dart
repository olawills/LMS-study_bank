import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/constants/custom_text_style.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper.dart';
import 'package:study_bank/mobileLayout/widgets/answers_card/answer_card.dart';
import 'package:study_bank/mobileLayout/widgets/components/answers_output_card.dart';
import 'package:study_bank/mobileLayout/widgets/components/content_area.dart';
import 'package:study_bank/mobileLayout/widgets/components/countdown_timer.dart';
import 'package:study_bank/mobileLayout/widgets/components/custom_app_bar.dart';
import 'package:study_bank/mobileLayout/widgets/components/main_buttons.dart';
import 'package:study_bank/mobileLayout/widgets/components/question_widget.dart';

class TestScreen extends GetView<QuestionController> {
  static String routeName = '/test_screen';
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTestQuestion,
      ),
      body: QuestionDecorationWidget(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountdownTimer(
                          color: UIInterface.isDarkMode()
                              ? Theme.of(context).textTheme.bodyLarge!.color
                              : Theme.of(context).primaryColor,
                          time: '',
                        ),
                        Obx(
                          () => Text(
                            '${controller.time} Remaining',
                            style: countDownTimerStyle(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (_, index) {
                          AnswerStatus? answerStatus;
                          if (controller.allQuestions[index].selectedAnswer !=
                              null) {
                            answerStatus = AnswerStatus.answered;
                          }
                          return AnswerOutputCard(
                            index: index + 1,
                            status: answerStatus,
                            onTap: () => controller.jumpToQuestion(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIInterface.mobileScreenPadding,
                child: MainButton(
                  onTap: () => controller.complete(),
                  title: 'Complete',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
