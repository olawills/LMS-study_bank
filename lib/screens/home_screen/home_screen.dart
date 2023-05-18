import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/zoom_controller/zoom_controller.dart';
import 'package:study_bank/screens/main_screen/main_screen.dart';
import 'package:study_bank/screens/menu_screen/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<MyZoomDrawerController>(builder: (_) {
      return ZoomDrawer(
        borderRadius: 50.0,
        showShadow: true,
        angle: 0.0,
        style: DrawerStyle.DefaultStyle,
        // menuBackgroundColor: Colors.white.withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.4,
        controller: _.zoomDrawerController,
        menuScreen: const MenuScreen(),
        mainScreen: const MainScreen(),
      );
    }));
  }
}
