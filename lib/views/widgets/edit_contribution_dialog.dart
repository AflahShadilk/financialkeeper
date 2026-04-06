// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_dialog.dart';
import 'package:financialkeeper/models/contribution_model.dart';
import 'package:financialkeeper/views/widgets/adding_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditContributionDialog extends GetView<GoalController> {
  final ContributionModel item;
  const EditContributionDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Note: In a production app, you might want to initialize 
    // the controllers with the 'item' values here if they aren't already handled.
    // Assuming GoalController handles this when the edit button is pressed.
    
    return AppDialog(
      title: "Edit Contribution",
      subtitle: "Update your contribution details.",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Amount Field
          TextField(
            controller: controller.editAmountController,
            focusNode: controller.editAmountFocus,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).requestFocus(controller.editNoteFocus),
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
            controller: controller.editNoteController,
            focusNode: controller.editNoteFocus,
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
            amountController: controller.editAmountController,
            noteController: controller.editNoteController,
            text: "Update Contribution",
            icon: Icons.check_circle_rounded,
            onPressed: () {
              final amountText = controller.editAmountController.text.trim();
              final note = controller.editNoteController.text.trim();
              
              if (amountText.isEmpty || note.isEmpty) {
                controller.showErrorSnackbar("Please fill in all fields");
                return;
              }

              final amount = double.tryParse(amountText);
              if (amount == null || amount <= 0) {
                controller.showErrorSnackbar("Invalid amount");
                return;
              }

              controller.updateContribution(item, amount, note);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
