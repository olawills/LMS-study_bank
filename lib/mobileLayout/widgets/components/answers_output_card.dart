import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';
import 'package:study_bank/mobileLayout/widgets/answers_card/answer_card.dart';

class AnswerOutputCard extends StatelessWidget {
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;
  const AnswerOutputCard({
    Key? key,
    required this.index,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        _backgroundColor:
        Get.isDarkMode
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.notanswered:
        backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);

        break;
      default:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      onTap: onTap,
      borderRadius: UIInterface.cardBorderRadius,
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: UIInterface.cardBorderRadius,
        ),
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(
              color: status == AnswerStatus.notanswered
                  ? Theme.of(context).primaryColor
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
