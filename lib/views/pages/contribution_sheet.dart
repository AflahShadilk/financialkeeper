import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/segmented_progress_bar.dart';
import 'package:financialkeeper/views/widgets/contribution_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ContributionSheet extends StatelessWidget {
  final GoalController controller;

  const ContributionSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    notification.metrics.pixels.clamp(0, 150),
                  );
                }
                return true;
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
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
                    Obx(() {
                      final currentGoal = controller.currentGoal;
                      if (currentGoal == null) {
                        return const SizedBox.shrink();
                      }
                      return SegmentedProgressBar(
                        contributions: controller.contributions,
                        targetAmount: currentGoal.targetAmount,
                      );
                    }),
                    24.h,
                    Obx(() {
                      if (controller.contributions.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Text(
                              "No contributions recorded for this goal",
                              style: TextStyle(color: AppColors.textLight),
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: controller.contributions
                              .map((c) => ContributionListItem(item: c))
                              .toList(),
                        );
                      }
                    }),
                    // space for FAB
                    80.h,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}