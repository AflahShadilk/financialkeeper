import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:financialkeeper/core/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  final String text;
  const InsightCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GlassCard(child: Row(
      children: [
        const Icon(Icons.lightbulb,color: AppColors.primary,),
        10.w,
        Expanded(child: AppText(text,size:13))
      ],
    ));
  }
}