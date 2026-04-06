// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget bottomNav() {
  return Container(
    height: 70,
    padding: const EdgeInsets.only(bottom: 10), 
    decoration: const BoxDecoration(
      color: AppColors.background, 
      border: Border(
        top: BorderSide(color: AppColors.border, width: 0.5),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        NavIcon(icon: Icons.home_filled, isActive: true),
        NavIcon(icon: Icons.swap_horizontal_circle_outlined),
        NavIcon(icon: Icons.pie_chart_outline_rounded),
        NavIcon(icon: Icons.settings_outlined),
      ],
    ),
  );
}

class NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  const NavIcon({super.key, required this.icon, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        color: isActive ? AppColors.textPrimary : AppColors.textSecondary.withOpacity(0.5),
        size: 28,
      ),
    );
  }
}