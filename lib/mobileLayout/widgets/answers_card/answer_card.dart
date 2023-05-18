import 'package:flutter/material.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';

enum AnswerStatus {
  correct,
  wrong,
  answered,
  notanswered,
}

class AnswersCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  const AnswersCard({
    Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: UIInterface.cardBorderRadius,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: UIInterface.cardBorderRadius,
          color:
              isSelected ? answerSlectedColor() : Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected ? answerSlectedColor() : answerBorderColor(),
          ),
        ),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,
          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  final String answer;
  const CorrectAnswer({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIInterface.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: correctAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  final String answer;
  const WrongAnswer({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIInterface.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: wrongAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotAnswered extends StatelessWidget {
  final String answer;
  const NotAnswered({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIInterface.cardBorderRadius,
        color: notAnsweredColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: notAnsweredColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
