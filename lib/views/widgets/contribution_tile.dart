import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:financialkeeper/models/contribution_model.dart';
import 'package:financialkeeper/views/widgets/delete_contribution_dailog.dart';
import 'package:financialkeeper/views/widgets/edit_contribution_bottum_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContributionTile extends GetView<GoalController> {
  final ContributionModel contribution;

  const ContributionTile({
    super.key,
    required this.contribution,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('dd MMM yyyy, hh:mm a').format(contribution.date);

    return ListTile(
      title: AppText(
        "₹${contribution.amount.toStringAsFixed(0)}",
      ),
      subtitle: AppText(
        formattedDate,
        size: 12,
        color: AppColors.textSecondary,
      ),
      leading: const Icon(
        Icons.arrow_upward,
        color: AppColors.success,
      ),
      trailing: PopupMenuButton(
        
        color: AppColors.backgroundSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                const Icon(Icons.edit, size: 18, color: AppColors.textPrimary),
                const SizedBox(width: 8),
                const Text(
                  "Edit",
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                const Icon(Icons.delete, size: 18, color: AppColors.error),
                const SizedBox(width: 8),
                const Text(
                  "Delete",
                  style: TextStyle(color: AppColors.error),
                ),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          if (value == 'delete') {
            Get.dialog(
              DeleteContributionDialog(item: contribution),
            );
          } else if (value == 'edit') {
            Get.bottomSheet(
              EditContributionSheet(item: contribution),
            );
          }
        },
      ),
    );
  }
}
