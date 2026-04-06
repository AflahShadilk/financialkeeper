// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GoalDotNavigator extends StatelessWidget {
  final int totalDots;
  final int activeIndex;
  final Function(int) onDotTap;

  const GoalDotNavigator({
    super.key,
    required this.totalDots,
    required this.activeIndex,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        final isActive = index == activeIndex;
        return GestureDetector(
          onTap: () => onDotTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.white : AppColors.white.withOpacity(0.4),
            ),
          ),
        );
      }),
    );
  }
}
