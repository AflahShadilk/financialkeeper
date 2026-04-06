// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/goal_controller.dart';
import '../../models/contribution_model.dart';
import '../../core/theme/app_colors.dart';

class DeleteContributionDialog extends GetView<GoalController> {
  final ContributionModel contribution;
  const DeleteContributionDialog({super.key, required this.contribution});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.backgroundSecondary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_sweep_rounded,
                  color: AppColors.error, size: 32),
            ),
            20.h,
            const Text(
              "Delete Contribution?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            12.h,
            Text(
              "This action cannot be undone. Your goal progress will be reversed.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            32.h,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.success),
                    ),
                  ),
                ),
                16.w,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.deleteContribution(contribution);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}