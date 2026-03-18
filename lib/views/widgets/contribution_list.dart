import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/views/widgets/contribution_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContributionList extends GetView<GoalController> {
  const ContributionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.contributions.length,
      itemBuilder: (context, index) {
        final contribution = controller.contributions[index];
        return ContributionTile(
          amount: '₹${contribution.amount.toStringAsFixed(0)}',
          date: _formatDate(contribution.date),
        );
      },
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}