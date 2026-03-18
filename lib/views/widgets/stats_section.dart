import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/views/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final double saved;
  final double target;
  const StatsSection({super.key, required this.saved, required this.target});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatCard(title: 'Saved', value: '₹${saved.toStringAsFixed(0)}'),
        12.w,
        StatCard(title: 'Target', value: '₹${target.toStringAsFixed(0)}')
      ],
    );
  }
}