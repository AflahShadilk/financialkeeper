import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/goal_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../models/contribution_model.dart';

class DeleteContributionDialog extends GetView<GoalController> {
  final ContributionModel item;

  const DeleteContributionDialog({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Delete Contribution",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            12.h,
            const Text(
              "Are you sure you want to delete this contribution?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            20.h,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
                12.w,
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      controller.deleteContribution(item);
                      Get.back();
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}