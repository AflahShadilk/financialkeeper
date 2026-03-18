import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerBox(width: 150, height: 20),
        20.h,
        ShimmerBox(width: 160 , height: 160),
        20.h,
        ShimmerBox(width: double.infinity, height: 80)
      ],
    );
  }
}
