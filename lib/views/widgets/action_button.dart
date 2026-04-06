import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/views/pages/add_contribution_dialog.dart';
import 'package:financialkeeper/views/pages/add_goal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final GoalController controller;

  const FloatingActionButtonWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Get.dialog(
          const AddGoalDialog(),
          barrierDismissible: true,
        );
      },
      onTap: () {
        if (controller.goals.isEmpty) return;
        Get.dialog(
          const AddContributionDialog(),
          barrierDismissible: true,
        );
      },
      child: FloatingActionButton(
        backgroundColor: AppColors.primary,
        elevation: 6,
        onPressed: null,
        child: const Icon(Icons.add, color: AppColors.white, size: 32),
      ),
    );
  }
}