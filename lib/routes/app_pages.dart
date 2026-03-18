import 'package:financialkeeper/bindings/goal_binding.dart';
import 'package:financialkeeper/views/pages/goal_screen.dart';
import 'package:financialkeeper/views/pages/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => SplashScreen(),
    ),
    GetPage(name: '/goal', page: () => GoalScreen(), binding: GoalBinding()),
  ];
}
