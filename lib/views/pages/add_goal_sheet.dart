import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGoalSheet extends GetView<GoalController> {
  const AddGoalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

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
          const Text(
            "Create Goal",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          20.h,
          TextField(
            controller: titleController,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: "Goal title",
              hintStyle: TextStyle(color: AppColors.textHint),
              filled: true,
              fillColor: AppColors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          16.h,
          TextField(
            controller: amountController,
            style: const TextStyle(color: AppColors.textPrimary),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Target amount",
              hintStyle: TextStyle(color: AppColors.textHint),
              filled: true,
              fillColor: AppColors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          20.h,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                controller.createGoal(
                  titleController.text,
                  double.parse(amountController.text),
                );
                Get.back();
              },
              child: const Text("Create Goal"),
            ),
          ),
        ],
      ),
    );
  }
}