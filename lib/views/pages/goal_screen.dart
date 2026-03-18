import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/views/widgets/contribution_list.dart';
import 'package:financialkeeper/views/widgets/goal_header.dart';
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
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const LoadingView();
                }
                final goal = controller.goal.value;
                if (goal == null) {
                  return const LoadingView();
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoalHeader(title: goal.title),
                      20.h,
                      GoalProgress(progress: controller.progress),
                      20.h,
                      StatsSection(
                          saved: goal.savedAmount, target: goal.targetAmount),
                      20.h,
                      InsightCard(text: controller.monthlySuggestion),
                      20.h,
                      Expanded(child: ContributionList())
                    ],
                  ),
                );
              }))),
    );
  }
}
