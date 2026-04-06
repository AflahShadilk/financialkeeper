// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/utils/formatter.dart';
import 'package:financialkeeper/core/widgets/action_button.dart';
import 'package:financialkeeper/core/widgets/circular_progress_widget.dart';
import 'package:financialkeeper/core/widgets/segmented_progress_bar.dart';
import 'package:financialkeeper/views/widgets/contribution_list.dart';
import 'package:financialkeeper/core/widgets/goal_dot_navigator.dart';
import 'package:financialkeeper/views/pages/add_contribution_dialog.dart';
import 'package:financialkeeper/views/pages/add_goal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

        final currentGoal = controller.currentGoal!;

        return Stack(
          children: [
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: SafeArea(
                  child: PageView.builder(
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
                            GoalDotNavigator(
                              totalDots: controller.goals.length,
                              activeIndex: controller.currentGoalIndex.value,
                              onDotTap: (idx) => controller.goToGoal(idx),
                            ),
                            24.h,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Goal",
                                  style: TextStyle(
                                      fontSize: 15,fontWeight: FontWeight.w600, color: AppColors.textLight),
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
                                    fontSize: 10, color: AppColors.textLight),
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
                                  controller.calculateMonthlyProjection(goal)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.70 -
                  (controller.scrollOffset.value * 0.4),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x20000000),
                      blurRadius: 15,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    12.h,
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollUpdateNotification) {
                            controller.updateScrollOffset(
                                notification.metrics.pixels.clamp(0, 150));
                          }
                          return true;
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Contributions",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){},
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    child: Text(
                                      "Show History",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.progressBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              16.h,
                              SegmentedProgressBar(
                                contributions: controller.contributions,
                                targetAmount: currentGoal.targetAmount,
                              ),
                              24.h,
                              if (controller.contributions.isEmpty)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(40),
                                    child: Text(
                                      "No contributions recorded for this goal",
                                      style:
                                          TextStyle(color: AppColors.textLight),
                                    ),
                                  ),
                                )
                              else
                                ...controller.contributions
                                    .map((c) => ContributionListItem(item: c)),
                              // Extra space for FAB
                              80.h,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: GestureDetector(
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
      ),
    );
  }
}

