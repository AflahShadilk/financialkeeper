import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ContributionTile extends StatelessWidget {
  final String amount;
  final String date;
  const ContributionTile({super.key, required this.amount, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.arrow_upward,
        color: AppColors.success,
      ),
      title: AppText(amount),
      subtitle: AppText(
        date,
        size: 12,
        color: AppColors.textSecondary,
      ),
    );
  }
}
