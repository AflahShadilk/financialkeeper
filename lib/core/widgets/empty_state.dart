import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyState({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.white10),
          16.h,
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontFamily: 'Outfit',
            ),
          ),
        ],
      ),
    );
  }
}
