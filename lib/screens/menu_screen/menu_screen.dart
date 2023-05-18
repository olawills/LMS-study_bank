import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';
import 'package:study_bank/mobileLayout/controllers/zoom_controller/zoom_controller.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIInterface.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      child: Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: onSurfaceTextColor),
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    controller.toggleDrawer();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.3,
                ),
                child: Column(
                  children: [
                    Obx(
                      () => controller.user.value == null
                          ? const SizedBox()
                          : Text(
                              controller.user.value!.displayName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: onSurfaceTextColor,
                              ),
                            ),
                    ),
                    const Spacer(flex: 1),
                    _DrawerButton(
                      icon: Icons.web,
                      label: 'Source Code',
                      onPressed: () => controller.showProfileInfo(),
                    ),
                    _DrawerButton(
                      icon: Icons.facebook,
                      label: 'Github Profile',
                      onPressed: () => controller.showGitAccount(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: _DrawerButton(
                        icon: Icons.email,
                        label: 'Email',
                        onPressed: () => controller.sendEmail(),
                      ),
                    ),
                    const Spacer(flex: 4),
                    Obx(
                      () => controller.user.value == null
                          ? _DrawerButton(
                              icon: Icons.logout,
                              label: 'Sign In',
                              onPressed: () => controller.signIn(),
                            )
                          : _DrawerButton(
                              icon: Icons.logout,
                              label: 'logout',
                              onPressed: () => controller.signOut(),
                            ),
                    ),
                    // _DrawerButton(
                    //   icon: Icons.logout,
                    //   label:
                    //       controller.user.value == null ? 'logout' : 'Log in',
                    //   onPressed: () => controller.signOut(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  const _DrawerButton(
      {Key? key, required this.icon, required this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 15,
      ),
      label: Text(label),
    );
  }
}
