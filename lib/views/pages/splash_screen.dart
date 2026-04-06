import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/extensions/spacing.dart';
import '../../core/widgets/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scaleAnimation;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
    navigateNext();
  }

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();
  }

  void navigateNext() {
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      Get.offAllNamed(user != null ? '/goal' : '/login');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientStart,
              AppColors.gradientMiddle,
              AppColors.gradientEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.savings_rounded,
                    size: 48,
                    color: AppColors.textPrimary,
                  ),
                ),
                20.h,
                const AppText(
                  "Financial Keeper",
                  size: 26,
                  weight: FontWeight.bold,
                ),
                10.h,
                const AppText(
                  "Track • Save • Grow",
                  size: 14,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}