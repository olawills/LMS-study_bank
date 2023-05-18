import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/loading_status.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper.dart';
import 'package:study_bank/mobileLayout/widgets/answers_card/answer_card.dart';
import 'package:study_bank/mobileLayout/widgets/components/content_area.dart';
import 'package:study_bank/mobileLayout/widgets/components/countdown_timer.dart';
import 'package:study_bank/mobileLayout/widgets/components/main_buttons.dart';
import 'package:study_bank/mobileLayout/widgets/components/question_widget.dart';
import 'package:study_bank/mobileLayout/widgets/components/shimmer_loader.dart';
import 'package:study_bank/screens/test_overview_screen/test_screen.dart';

import '../../configs/constants/custom_text_style.dart';
import '../../mobileLayout/widgets/components/custom_app_bar.dart';

class QuestionScreen extends GetView<QuestionController> {
  static String routeName = '/question_screen';
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(color: onSurfaceTextColor, width: 2),
            ),
          ),
          child: Obx(
            () => CountdownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
            ),
          ),
        ),
        showActionIcon: true,
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
            style: appBarTs,
          ),
        ),
      ),
      body: QuestionDecorationWidget(
        child: Obx(
          () => Column(
            children: [
              if (controller.loadingStatus.value == LoadingStatus.loading)
                const Expanded(
                    child: ContentArea(child: ShimmerLoaderWidget())),
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                  child: ContentArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Text(
                            controller.currentQuestions.value!.question,
                            style: questionText,
                          ),
                          GetBuilder<QuestionController>(
                            id: 'answers_list',
                            builder: (context) {
                              return ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 25),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .currentQuestions.value!.answers.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(height: 10);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  final answer = controller
                                      .currentQuestions.value!.answers[index];
                                  return AnswersCard(
                                    answer:
                                        "${answer.identifier}, ${answer.answer}",
                                    onTap: () {
                                      controller
                                          .selectedAnswer(answer.identifier);
                                    },
                                    isSelected: answer.identifier ==
                                        controller.currentQuestions.value!
                                            .selectedAnswer,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIInterface.mobileScreenPadding,
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: MainButton(
                            onTap: () {
                              controller.previousQuestion();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                          visible: controller.loadingStatus.value ==
                              LoadingStatus.completed,
                          child: MainButton(
                            onTap: () {
                              controller.isLastQuestion
                                  ? Get.toNamed(TestScreen.routeName)
                                  : controller.nextQuestion();
                            },
                            title:
                                controller.isLastQuestion ? 'Complete' : 'Next',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
