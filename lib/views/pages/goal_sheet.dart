import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/utils/formatter.dart';
import 'package:financialkeeper/core/widgets/action_button.dart';
import 'package:financialkeeper/core/widgets/circular_progress_widget.dart';
import 'package:financialkeeper/core/widgets/goal_dot_navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

class GoalPageView extends StatelessWidget {
  final GoalController controller;

  const GoalPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: controller.goals.length,
      onPageChanged: controller.onGoalChanged,
      itemBuilder: (context, index) {
        final goal = controller.goals[index];
        final progress = goal.percentComplete;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              20.h,
              Text(
                goal.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              26.h,
              CircularProgressWidget(
                progress: progress,
                centerText: Formatter.currency(goal.savedAmount),
                subtitle: "You Saved",
                size: 160,
              ),
              16.h,
              Obx(() {
                return GoalDotNavigator(
                  totalDots: controller.goals.length,
                  activeIndex: controller.currentGoalIndex.value,
                  onDotTap: (idx) => controller.goToGoal(idx),
                );
              }),
              24.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Goal",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textLight,
                    ),
                  ),
                  Text(
                    Formatter.currency(goal.targetAmount),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "by ${DateFormat('MMM yyyy').format(goal.deadline)}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textLight,
                  ),
                ),
              ),
              16.h,
              ActionButton(
                label: "Need more savings",
                amount: Formatter.currency(
                  (goal.targetAmount - goal.savedAmount)
                      .clamp(0, double.infinity),
                ),
              ),
              8.h,
              ActionButton(
                label: "Monthly Saving Projection",
                amount: Formatter.currency(
                  controller.calculateMonthlyProjection(goal),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
