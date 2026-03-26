import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddingButton extends StatelessWidget {
  const AddingButton({
    super.key,
    required this.controller,
    this.amountController,
    this.icon,
    this.text,
    this.onPressed,
    this.width,
  });

  final GoalController controller;
  final TextEditingController? amountController;
  final IconData? icon;
  final String? text;
  final VoidCallback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: onPressed ??
              () {
                if (amountController != null) {
                  final success = controller.addContribution(
                    double.parse(amountController!.text),
                  );
                  if (success) {
                    Get.back();
                  }
                }
              },
          child: icon != null && text != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: AppColors.success),
                    const SizedBox(width: 8),
                    Text(text!, style: const TextStyle(color: Colors.white)),
                  ],
                )
              : text != null
                  ? Text(
                      text!,
                      style: const TextStyle(color: Colors.white),
                    )
                  : Icon(
                      icon ?? Icons.arrow_upward,
                      color: AppColors.success,
                      size: 24,
                    ),
        ),
      ),
    );
  }
}