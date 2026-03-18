import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  const AppText(
    this.text,
    {super.key, 
    this.size = 14, 
    this.weight = FontWeight.normal,
     this.color });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color??AppColors.textPrimary
      ),
    );
  }
}