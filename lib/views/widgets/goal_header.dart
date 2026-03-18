import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class GoalHeader extends StatelessWidget {
  const GoalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Your Goal',
          size: 14,
          color: AppColors.textSecondary,
        ),
        6.h,
        AppText(
          'Buy Dream House',
          size: 22,
          weight: FontWeight.bold,
        )
      ],
    );
  }
}
