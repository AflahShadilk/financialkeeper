import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:financialkeeper/views/widgets/gradient_progress.dart';
import 'package:flutter/material.dart';

class GoalProgress extends StatelessWidget {
  final double progress;
  const GoalProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: progress),
          duration: const Duration(seconds: 2),
          builder: (context, value, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: 160,
                    width: 160,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GradientProgress(progress: value),
                        AppText(
                          '${(value * 100).toInt()}%',
                          size: 22,
                          weight: FontWeight.bold,
                        )
                        
                      ],
                    )),
              ],
            );
          }),
    );
  }
}
