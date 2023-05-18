import 'package:flutter/material.dart';
import 'package:study_bank/configs/constants/custom_text_style.dart';

class CountdownTimer extends StatelessWidget {
  final Color? color;
  final String time;
  const CountdownTimer({Key? key, this.color, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 5),
        Text(
          time,
          style: countDownTimerStyle().copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
