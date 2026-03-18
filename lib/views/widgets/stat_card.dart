import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:financialkeeper/core/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GlassCard(child: Column(
      children: [
        AppText(title,size: 12,color: AppColors.textSecondary,),
        6.h,
        AppText(value,size: 16,weight: FontWeight.bold,)
      ],
    )));
  }
}