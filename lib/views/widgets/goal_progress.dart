import 'package:financialkeeper/core/theme/app_colors.dart';
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
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 10,
                      backgroundColor: AppColors.progressBackground,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    )),
              ],
            );
          }),
    );
  }
}
