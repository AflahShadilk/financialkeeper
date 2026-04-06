// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_dialog.dart';
import 'package:financialkeeper/views/widgets/adding_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContributionDialog extends GetView<GoalController> {
  const AddContributionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: "Add Contribution",
      subtitle: "Every rupee counts towards your dream goal.",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Amount Field
          TextField(
            controller: controller.contributionAmountController,
            focusNode: controller.contributionAmountFocus,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).requestFocus(controller.contributionNoteFocus),
            style: const TextStyle(color: AppColors.white, fontSize: 18),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.currency_rupee_rounded, color: AppColors.primary, size: 20),
              hintText: "Enter amount",
              hintStyle: TextStyle(color: AppColors.white60.withOpacity(0.3)),
              filled: true,
              fillColor: AppColors.white05,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
          16.h,
          
          // Note Field
          TextField(
            controller: controller.contributionNoteController,
            focusNode: controller.contributionNoteFocus,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.edit_note_rounded, color: AppColors.primary),
              hintText: "Source (e.g. Monthly Salary)",
              hintStyle: TextStyle(color: AppColors.white60.withOpacity(0.3)),
              filled: true,
              fillColor: AppColors.white05,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
          32.h,
          
          AddingButton(
            controller: controller,
            amountController: controller.contributionAmountController,
            noteController: controller.contributionNoteController,
            text: "Confirm Contribution",
            icon: Icons.check_circle_rounded,
          ),
        ],
      ),
    );
  }
}
