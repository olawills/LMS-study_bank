import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_bank/configs/app_icons/app_icons.dart';
import 'package:study_bank/configs/constants/custom_text_style.dart';
import 'package:study_bank/configs/themes/app_colors.dart';
import 'package:study_bank/configs/themes/ui_interface.dart';
import 'package:study_bank/mobileLayout/controllers/question_paper/question_paper_controllers/question_paper_controller.dart';
import 'package:study_bank/mobileLayout/controllers/zoom_controller/zoom_controller.dart';
import 'package:study_bank/mobileLayout/widgets/components/content_area.dart';
import 'package:study_bank/screens/question_card/question_card.dart';

class MainScreen extends GetView<MyZoomDrawerController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    return Container(
      decoration: BoxDecoration(
        gradient: mainGradient(),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(mobileScreenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: controller.toggleDrawer,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Icon(
                        AppIcons.menuLeft,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          AppIcons.peace,
                        ),
                        Obx(
                          () => controller.user.value == null
                              ? Text(
                                  'Hello Welcome',
                                  style: detailText.copyWith(
                                      color: onSurfaceTextColor),
                                )
                              : Row(
                                  children: [
                                    Text(
                                      'Hello ${controller.user.value!.displayName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: onSurfaceTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'What do you want to learn today?',
                    style: headerText,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ContentArea(
                  addPadding: false,
                  child: Obx(
                    () => ListView.separated(
                      padding: UIInterface.mobileScreenPadding,
                      itemBuilder: (BuildContext context, int index) {
                        return QuestionCard(
                          model: questionPaperController.allPapers[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 20);
                      },
                      itemCount: questionPaperController.allPapers.length,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
