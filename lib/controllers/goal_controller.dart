import 'package:get/get.dart';
import '../models/goal_model.dart';
import '../models/contribution_model.dart';

class GoalController extends GetxController {
  var isLoading = true.obs;

  var goal = Rxn<GoalModel>();
  var contributions = <ContributionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData(); // later replace with Firebase
  }

  
  void loadDummyData() async {
    await Future.delayed(const Duration(seconds: 1));

    goal.value = GoalModel(
      title: "Buy Dream House",
      savedAmount: 50000,
      targetAmount: 100000,
      deadline: DateTime(2026, 12, 31),
    );

    contributions.value = [
      ContributionModel(amount: 2000, date: DateTime(2026, 1, 10)),
      ContributionModel(amount: 3000, date: DateTime(2026, 1, 15)),
      ContributionModel(amount: 5000, date: DateTime(2026, 2, 1)),
    ];

    isLoading.value = false;
  }

  // Progress calculation
  double get progress {
    if (goal.value == null) return 0;
    return goal.value!.savedAmount / goal.value!.targetAmount;
  }

  // Monthly suggestion
  String get monthlySuggestion {
    if (goal.value == null) return "";

    final remaining =
        goal.value!.targetAmount - goal.value!.savedAmount;

    final monthsLeft =
        goal.value!.deadline.difference(DateTime.now()).inDays ~/ 30;

    if (monthsLeft <= 0) return "Deadline reached";

    final perMonth = remaining / monthsLeft;

    return "Save ₹${perMonth.toStringAsFixed(0)}/month to reach your goal";
  }
}