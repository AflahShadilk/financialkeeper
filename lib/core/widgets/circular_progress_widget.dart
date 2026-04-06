// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String centerText;
  final String subtitle;
  final double size;

  const CircularProgressWidget({
    super.key,
    required this.progress,
    required this.centerText,
    required this.subtitle,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: ArcPainter(
                progress: progress,
                color: AppColors.white,
                backgroundColor: AppColors.white.withOpacity(0.1),
                strokeWidth: size * 0.08, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    centerText,
                    style: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  ArcPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    this.strokeWidth = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw full background circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi,
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
