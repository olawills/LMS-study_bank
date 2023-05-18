import 'package:flutter/material.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';

class ContentArea extends StatelessWidget {
  final bool addPadding;
  final Widget child;
  const ContentArea({Key? key, this.addPadding = true, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        padding: addPadding
            ? EdgeInsets.only(
                top: mobileScreenPadding,
                left: mobileScreenPadding,
                right: mobileScreenPadding,
              )
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: customScaffoldColor(context),
        ),
        child: child,
      ),
    );
  }
}
