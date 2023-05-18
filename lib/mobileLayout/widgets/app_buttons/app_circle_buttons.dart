import 'package:flutter/material.dart';

class AppCircleButtons extends StatelessWidget {
  const AppCircleButtons({
    Key? key,
    required this.child,
    this.colour,
    this.onTap,
    this.width = 60,
  }) : super(key: key);

  final Widget child;
  final Color? colour;
  final double width;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
