import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/views/pages/add_contribution_sheet.dart';
import 'package:financialkeeper/views/pages/add_goal_sheet.dart';
import 'package:financialkeeper/views/widgets/contribution_list.dart';
import 'package:financialkeeper/views/widgets/goal_progress.dart';
import 'package:financialkeeper/views/widgets/insight_card.dart';
import 'package:financialkeeper/views/widgets/loading_view.dart';
import 'package:financialkeeper/views/widgets/stats_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalScreen extends GetView<GoalController> {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      floatingActionButton: Obx(() {
        if (controller.goal.value == null || controller.progress >= 1) return const SizedBox();

        return FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Get.bottomSheet(const AddContributionSheet());
          },
          child: const Icon(Icons.add),
        );
      }),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const LoadingView();
            }

            final goal = controller.goal.value;

            if (goal == null) {
              return Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    Get.bottomSheet(const AddGoalSheet());
                  },
                  child: const Text("Create Your First Goal"),
                ),
              );
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    goal.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  24.h,

                  Center(
                    child: GoalProgress(
                      progress: controller.progress,
                    ),
                  ),

                  24.h,

                  StatsSection(
                    saved: goal.savedAmount,
                    target: goal.targetAmount,
                  ),

                  20.h,

                  InsightCard(text: controller.monthlySuggestion),

                  20.h,

                  const Expanded(
                    child: ContributionList(),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}