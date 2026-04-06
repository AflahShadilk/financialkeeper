import 'package:financialkeeper/bindings/goal_binding.dart';
import 'package:financialkeeper/views/pages/goals_screen.dart';
import 'package:financialkeeper/views/pages/login_screen.dart';
import 'package:financialkeeper/views/pages/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => SplashScreen(),
    ),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/goal', page: () => const GoalsScreen(), binding: GoalBinding()),
    
  ];
}
