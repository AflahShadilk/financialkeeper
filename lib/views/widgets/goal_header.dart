import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GoalHeader extends StatelessWidget {
  final String title;

  const GoalHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
