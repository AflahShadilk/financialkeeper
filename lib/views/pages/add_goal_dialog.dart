// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_dialog.dart';
import 'package:financialkeeper/views/widgets/adding_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddGoalDialog extends GetView<GoalController> {
  const AddGoalDialog({super.key});

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.backgroundSecondary,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.background,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.setSelectedDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: "Start Your Journey",
      subtitle: "Define your dream goal and set a target.",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Goal Title
          TextField(
            controller: controller.goalTitleController,
            focusNode: controller.goalTitleFocus,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).requestFocus(controller.goalAmountFocus),
            style: const TextStyle(color: AppColors.white, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 22),
              hintText: "What are you saving for?",
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
          
          // Target Amount
          TextField(
            controller: controller.goalAmountController,
            focusNode: controller.goalAmountFocus,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary, size: 22),
              hintText: "Target Amount",
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
          
          // Deadline Picker
          InkWell(
            onTap: () => selectDate(context),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.white05,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() {
                final date = controller.selectedDate.value;
                return Row(
                  children: [
                    const Icon(Icons.event_repeat_rounded, color: AppColors.primary, size: 22),
                    12.w,
                    Text(
                      date == null
                          ? "Completion Date"
                          : "Target: ${DateFormat('MMMM yyyy').format(date)}",
                      style: TextStyle(
                        color: date == null ? AppColors.white60 : AppColors.white,
                        fontSize: 16,
                        fontWeight: date == null ? FontWeight.normal : FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded, color: AppColors.white10),
                  ],
                );
              }),
            ),
          ),
          32.h,
          
          AddingButton(
            controller: controller,
            text: "Create My Goal",
            icon: Icons.rocket_launch_rounded,
            onPressed: () {
              final title = controller.goalTitleController.text.trim();
              final amountText = controller.goalAmountController.text.trim();
              final date = controller.selectedDate.value;

              if (title.isEmpty || amountText.isEmpty || date == null) {
                controller.showErrorSnackbar("Please complete all sections");
                return;
              }

              final amount = double.tryParse(amountText);
              if (amount == null || amount <= 0) {
                controller.showErrorSnackbar("Invalid target amount");
                return;
              }

              final success = controller.createGoal(title, amount, date);
              if (success) {
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }
}
