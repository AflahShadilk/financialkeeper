// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/utils/formatter.dart';
import 'package:financialkeeper/models/contribution_model.dart';
import 'package:financialkeeper/views/widgets/delete_contribution_dailog.dart';
import 'package:financialkeeper/views/widgets/edit_contribution_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContributionListItem extends GetView<GoalController> {
  final ContributionModel item;
  const ContributionListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.note,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              8.w,
              Text(
                Formatter.currency(item.amount),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          6.h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMM d, yyyy').format(item.date),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit_rounded,
                      size: 16,
                      color: AppColors.textLight,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.editAmountController.text =
                          item.amount.toString();
                      controller.editNoteController.text = item.note;

                      Get.dialog(
                        EditContributionDialog(item: item),
                        barrierDismissible: true,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 16,
                      color: AppColors.error,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Get.dialog(
                      DeleteContributionDialog(contribution: item),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
