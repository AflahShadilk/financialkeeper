// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/models/contribution_model.dart';
import 'package:flutter/material.dart';

class SegmentedProgressBar extends StatelessWidget {
  final List<ContributionModel> contributions;
  final double targetAmount;
  final double height;
  final double borderRadius;

  const SegmentedProgressBar({
    super.key,
    required this.contributions,
    required this.targetAmount,
    this.height = 8,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    if (targetAmount <= 0) return const SizedBox.shrink();
    final Map<ContributionType, double> totals = {
      ContributionType.salary: 0,
      ContributionType.bonus: 0,
      ContributionType.extra: 0,
    };

    for (var c in contributions) {
      totals[c.type] = (totals[c.type] ?? 0) + c.amount;
    }

    final totalSaved = totals.values.fold(0.0, (sum, val) => sum + val);
    final remaining = (targetAmount - totalSaved).clamp(0.0, double.infinity);

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.divider.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Row(
          children: [
            if (totals[ContributionType.salary]! > 0)
              Flexible(
                flex: (totals[ContributionType.salary]!).toInt(),
                child: Container(color: AppColors.progressBlue),
              ),
            if (totals[ContributionType.bonus]! > 0)
              Flexible(
                flex: (totals[ContributionType.bonus]!).toInt(),
                child: Container(color: AppColors.progressYellow),
              ),
            if (totals[ContributionType.extra]! > 0)
              Flexible(
                flex: (totals[ContributionType.extra]!).toInt(),
                child: Container(color: AppColors.progressTeal),
              ),
            if (remaining > 0)
              Flexible(
                flex: remaining.toInt(),
                child: Container(color: Colors.transparent),
              ),
          ],
        ),
      ),
    );
  }
}
