import 'package:financialkeeper/services/firebase_service.dart';
import 'package:get/get.dart';
import '../models/goal_model.dart';
import '../models/contribution_model.dart';

class GoalController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var isLoading = true.obs;

  var goal = Rxn<GoalModel>();
  var contributions = <ContributionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToGoal();
  }

  //goallistening
  void listenToGoal() {
    _firebaseService.getGoals().listen((data) {
      goal.value = data;
      isLoading.value = false;
    });
  }

  //contribution listening
  void listenToContributions() {
    _firebaseService.getContributions().listen((data) {
      contributions.value = data;
    });
  }

  // Progress calculation
  double get progress {
    if (goal.value == null) return 0;
    return goal.value!.savedAmount / goal.value!.targetAmount;
  }

  // Monthly suggestion
  String get monthlySuggestion {
    if (goal.value == null) return "";

    final remaining = goal.value!.targetAmount - goal.value!.savedAmount;

    final monthsLeft =
        goal.value!.deadline.difference(DateTime.now()).inDays ~/ 30;

    if (monthsLeft <= 0) return "Deadline reached";

    final perMonth = remaining / monthsLeft;

    return "Save ₹${perMonth.toStringAsFixed(0)}/month to reach your goal";
  }
}
