 // ignore_for_file: deprecated_member_use

 import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:get/get.dart';

void showLimitDialog() {
    Get.defaultDialog(
      title: "Alert",
      middleText: "contribution do not cross greater than target amount",
      textConfirm: "OK",
      confirmTextColor: AppColors.textPrimary,
      buttonColor: AppColors.error,
      onConfirm: () => Get.back(),
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error.withOpacity(0.8),
      colorText: AppColors.textPrimary,
      duration: const Duration(seconds: 2),
    );
  }