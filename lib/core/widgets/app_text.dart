import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;

  const AppText(
    this.text, {
    super.key,
    this.size = 14,
    this.weight = FontWeight.normal,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? AppColors.textPrimary,
        fontFamily: 'Outfit',
      ),
    );
  }
}