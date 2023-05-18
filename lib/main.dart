// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/bindings/initial_binding.dart';
import 'package:study_bank/firebase_options.dart';
import 'package:study_bank/mobileLayout/controllers/theme_controller.dart';
import 'package:study_bank/routes/app_routes.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   InitialBindings().dependencies();
//   runApp(const MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme,
      title: 'Study App',
      getPages: AppRoutes.routes(),
      // home: DataUploadScreen(),
    );
  }
}
