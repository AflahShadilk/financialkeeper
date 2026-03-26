// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/services/firebase_service.dart';
import 'package:financialkeeper/views/widgets/limit_dailog.dart';
import 'package:get/get.dart';
import '../models/goal_model.dart';
import '../models/contribution_model.dart';

class GoalController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var isLoading = true.obs;

  var goal = Rxn<GoalModel>();
  var contributions = <ContributionModel>[].obs;
  var selectedDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    listenToGoal();
    listenToContributions();
  }
///goal related -----------------------------
  //goallistening
  void listenToGoal() {
    _firebaseService.getGoals().listen((data) {
      goal.value = data;
      isLoading.value = false;
    });
  }

    //goal creation
  bool createGoal(String title, double amount, DateTime deadline) {
    if (amount <= 0) {
      showErrorSnackbar("can't add");
      return false;
    }
    _firebaseService.createGoal(title, amount, deadline);
    selectedDate.value = null; 
    return true;
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }


  /// contribution related -----------------------------
  //contribution listening
  void listenToContributions() {
    _firebaseService.getContributions().listen((data) {
      contributions.value = data;
    });
  }

 //add contribution
  bool addContribution(double amount) {
    if (amount <= 0) {
      showErrorSnackbar("can't add");
      return false;
    }
    if (goal.value != null && (goal.value!.savedAmount + amount) > goal.value!.targetAmount) {
      showErrorSnackbar("contribution do not cross greater than target amount");
      return false;
    }
    _firebaseService.addContribution(amount);
    return true;
  }
  //update contribution
  bool updateContribution(ContributionModel contribution, double newAmount) {
    if (newAmount <= 0) {
      showErrorSnackbar("can't add");
      return false;
    }
    if (goal.value != null && (goal.value!.savedAmount - contribution.amount + newAmount) > goal.value!.targetAmount) {
      showErrorSnackbar("contribution do not cross greater than target amount");
      return false;
    }
    _firebaseService.updateContribution(contribution.id, contribution.amount, newAmount);
    return true;
  }

  //delete contribution
  void deleteContribution(ContributionModel contribution) {
    _firebaseService.deleteContribution(contribution.id, contribution.amount);
  }
  // Progress calculation
  double get progress {
    if (goal.value == null) return 0;
    return goal.value!.savedAmount / goal.value!.targetAmount;
  }

  // Monthly suggestion
  String get monthlySuggestion {
  if (goal.value == null) return "";

  final goalData = goal.value!;
  final daysLeft =
      goalData.deadline.difference(DateTime.now()).inDays;

  if (daysLeft <= 0) return "Deadline reached";

  final monthsLeft = daysLeft ~/ 30;

  final remainingAmount =
      goalData.targetAmount - goalData.savedAmount;

  if (remainingAmount <= 0) {
    return "Goal achieved! You can stop contributing to this.";
  }

  final deadlineText =
      "${goalData.deadline.day}/${goalData.deadline.month}/${goalData.deadline.year}";

  if (daysLeft <= 90) {
    final weeksLeft = daysLeft / 7;
    final perWeek = remainingAmount / weeksLeft;

    return "Save ₹${perWeek.toStringAsFixed(0)}/week till $deadlineText to reach your goal";
  }

  final perMonth = remainingAmount / monthsLeft;

  final timeText =
      monthsLeft > 0 ? "$monthsLeft months" : "$daysLeft days";

  return "Save ₹${perMonth.toStringAsFixed(0)}/month for $timeText (before $deadlineText)";
}
}
