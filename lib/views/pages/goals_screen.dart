// ignore_for_file: deprecated_member_use
import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/views/pages/contribution_sheet.dart';
import 'package:financialkeeper/views/pages/goal_sheet.dart';
import 'package:financialkeeper/views/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsScreen extends GetView<GoalController> {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.goals.isEmpty) {
          return Center(
            child: Text(
              "No goals set yet",
              style: TextStyle(color: AppColors.textLight),
            ),
          );
        }

        return Stack(
          children: [
           
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: SafeArea(
                  child: GoalPageView(controller: controller),
                ),
              ),
            ),

           
            Obx(() {
              return Positioned.fill(
                top: MediaQuery.of(context).size.height * 0.70 -
                    (controller.scrollOffset.value * 0.53), 
                child: ContributionSheet(controller: controller),
              );
            }),
          ],
        );
      }),
      floatingActionButton: FloatingActionButtonWidget(controller: controller),
    );
  }
}







