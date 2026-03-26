// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/views/widgets/adding_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContributionSheet extends GetView<GoalController> {
  const AddContributionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:  Text(
              "Add Contribution",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary.withOpacity(0.7)),
            ),
          ),
          20.h,
          TextField(
            controller: amountController,
            style: const TextStyle(color: AppColors.textPrimary),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter amount",
              hintStyle: TextStyle(color: AppColors.textPrimary.withOpacity(0.5)),
              filled: true,
              fillColor: AppColors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          20.h,
          AddingButton(controller: controller, amountController: amountController),
        ],
      ),
    );
  }
}

