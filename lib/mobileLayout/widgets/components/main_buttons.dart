import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_colors.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool enabled;
  final Widget? child;
  final Color? color;
  const MainButton({
    Key? key,
    this.title = '',
    required this.onTap,
    this.enabled = true,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 55,
        // width: 300,
        child: InkWell(
          onTap: enabled == false ? null : onTap,
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color ?? Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: child ??
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? onSurfaceTextColor
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
