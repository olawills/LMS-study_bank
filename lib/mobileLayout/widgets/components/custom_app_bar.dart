import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/app_icons/app_icons.dart';
import 'package:study_bank/configs/constants/custom_text_style.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';
import 'package:study_bank/screens/test_overview_screen/test_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;
  final Widget? leading;
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.titleWidget,
    this.leading,
    this.showActionIcon = false,
    this.onMenuActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding,
          vertical: mobileScreenPadding,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarTs,
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ??
                    Transform.translate(
                      offset: const Offset(-14, 0),
                      child: const BackButton(),
                    ),
                if (showActionIcon)
                  Transform.translate(
                    offset: const Offset(10, 0),
                    child: GestureDetector(
                      onTap: onMenuActionTap ??
                          () => Get.toNamed(TestScreen.routeName),
                      child: const Icon(AppIcons.menu),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
