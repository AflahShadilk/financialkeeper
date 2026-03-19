import 'package:financialkeeper/controllers/goal_controller.dart';
import 'package:financialkeeper/core/widgets/empty_state.dart';
import 'package:financialkeeper/views/widgets/contribution_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContributionList extends GetView<GoalController> {
  const ContributionList({super.key});

  @override
Widget build(BuildContext context) {
  return Obx(() {
    final list = controller.contributions;

    if (list.isEmpty) {
      return const EmptyState(message: "No contributions yet");
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ContributionTile(contribution: list[index],);
      },
    );
  });
}
}
