// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/core/extensions/spacing.dart';
import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final double maxWidth;

  const AppDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.maxWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.white10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.5),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    if (subtitle != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        subtitle!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.white60,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => Get.back(),
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: AppColors.white60,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          24.h,
                          child,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
