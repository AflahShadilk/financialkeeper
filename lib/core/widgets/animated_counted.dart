import 'package:financialkeeper/core/utils/formatter.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final double value;
  const AnimatedCounter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(seconds: 2),
      builder: (context, val, _) {
        return AppText(
          Formatter.compactCurrency(val),
          size: 16,
          weight: FontWeight.bold,
        );
      },
    );
  }
}
