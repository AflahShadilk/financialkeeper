import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GradientProgress extends StatelessWidget {
  final double progress; 
  const GradientProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(

    );
  }
}

class GradientPainter extends CustomPainter {
  final double progress;
  GradientPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect =Offset.zero & size;

    final gradient =SweepGradient(
      startAngle: -3.14 / 2 ,
      endAngle: 3.14 * 2 ,

      colors: [
       AppColors.primary,
       AppColors.secondary,
    ]);

    final paint = Paint()
    ..shader = gradient.createShader( rect)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..strokeCap = StrokeCap.round;

    final backgroundPaint = Paint()
    ..color = AppColors.progressBackground
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;

    canvas.drawCircle(size.center(Offset.zero), size.width/2,backgroundPaint);

    final sweepAngle = 3.14 * 2 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero),radius: size.width/2),-3.14/2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=> true;

}