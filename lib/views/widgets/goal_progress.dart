// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_text.dart';

class GoalProgress extends StatelessWidget {
  final double progress;

  const GoalProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: CustomPaint(
                painter: _ProgressPainter(value),
                child: const SizedBox(
                  width: 160,
                  height: 160,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  "${(value * 100).toInt()}%",
                  size: 26,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 4),
                AppText(
                  "Completed",
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 12.0;
    final radius = size.width / 2;

    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: radius,
    );

    final backgroundPaint = Paint()
      ..color = AppColors.progressBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(
      size.center(Offset.zero),
      radius,
      backgroundPaint,
    );

    final gradient = SweepGradient(
      startAngle: -3.14 / 2,
      endAngle: 3.14 * 2,
      colors: [
        AppColors.primary,
        AppColors.secondary,
      ],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.14 * progress;

    canvas.drawArc(
      rect,
      -3.14 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}