import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/goal_controller.dart';
import '../../models/contribution_model.dart';
import '../../core/theme/app_colors.dart';

class EditContributionSheet extends GetView<GoalController> {
  final ContributionModel item;

  const EditContributionSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controllerText =
        TextEditingController(text: item.amount.toString());

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Edit Contribution",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controllerText,
            style: const TextStyle(color: AppColors.textPrimary),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: () {
              controller.updateContribution(
                item,
                double.parse(controllerText.text),
              );
              Get.back();
            },
            child: const Text("Update", style: TextStyle(color: AppColors.textPrimary)),
          )
        ],
      ),
    );
  }
}