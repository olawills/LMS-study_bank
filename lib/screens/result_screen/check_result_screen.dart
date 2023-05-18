import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/constants/custom_text_style.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper.dart';
import 'package:study_bank/mobileLayout/widgets/answers_card/answer_card.dart';
import 'package:study_bank/mobileLayout/widgets/components/content_area.dart';
import 'package:study_bank/mobileLayout/widgets/components/custom_app_bar.dart';
import 'package:study_bank/mobileLayout/widgets/components/question_widget.dart';
import 'package:study_bank/screens/result_screen/result_screen.dart';

class CheckResultScreen extends GetView<QuestionController> {
  static const String routeName = '/check_result_screen';
  const CheckResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
            style: appBarTs,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: QuestionDecorationWidget(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestions.value!.question,
                        ),
                        GetBuilder<QuestionController>(
                            id: 'answer_review',
                            builder: (_) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .currentQuestions.value!.answers.length,
                                separatorBuilder: (_, int index) {
                                  return const SizedBox(height: 10);
                                },
                                itemBuilder: (_, int index) {
                                  final answer = controller
                                      .currentQuestions.value!.answers[index];
                                  final selectedAnswer = controller
                                      .currentQuestions.value!.selectedAnswer;
                                  final correctAnswer = controller
                                      .currentQuestions.value!.correctAnswer;
                                  final String answerText =
                                      '${answer.identifier}. ${answer.answer}';

                                  if (correctAnswer == selectedAnswer &&
                                      answer.identifier == selectedAnswer) {
                                    return CorrectAnswer(answer: answerText);
                                  } else if (selectedAnswer == null) {
                                    return NotAnswered(answer: answerText);
                                  } else if (correctAnswer != selectedAnswer &&
                                      answer.identifier == selectedAnswer) {
                                    return WrongAnswer(answer: answerText);
                                  } else if (correctAnswer ==
                                      answer.identifier) {
                                    return CorrectAnswer(answer: answerText);
                                  }
                                  return AnswersCard(
                                    answer: answerText,
                                    onTap: () {},
                                    isSelected: false,
                                  );
                                },
                              );
                            })
                      ],
                    ),
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
