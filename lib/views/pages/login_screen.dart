import 'package:financialkeeper/controllers/auth_controller.dart';
import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:financialkeeper/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white10,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white10, width: 2),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                40.h,
                const AppText(
                  "Financial Keeper",
                  size: 32,
                  weight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                10.h,
                const AppText(
                  "Smart management for your dreams",
                  size: 16,
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                ),
                60.h,
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.textDark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.signInWithGoogle(),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star_rounded, color: AppColors.primary),
                                  12.w,
                                  const Text(
                                    "Continue with Google",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    )),
                20.h,
                const AppText(
                  "Secure • Private • Real-time",
                  size: 12,
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