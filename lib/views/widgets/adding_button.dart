// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddingButton extends StatelessWidget {
  final GoalController controller;
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final TextEditingController? amountController;
  final TextEditingController? noteController;

  const AddingButton({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
    this.onPressed,
    this.amountController,
    this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        onPressed: onPressed ??
            () {
              if (amountController == null || noteController == null) return;
              
              final amountText = amountController!.text.trim();
              final note = noteController!.text.trim();

              if (amountText.isEmpty || note.isEmpty) {
                controller.showErrorSnackbar("Please enter all details");
                return;
              }

              final amount = double.tryParse(amountText);
              if (amount == null || amount <= 0) {
                controller.showErrorSnackbar("Invalid contribution amount");
                return;
              }

              final success = controller.addContribution(amount, note);
              if (success) {
                Get.back();
              }
            },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: AppColors.white),
            10.w,
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}