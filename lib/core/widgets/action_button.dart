// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final String amount;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.white,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
