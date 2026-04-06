// ignore_for_file: deprecated_member_use

import 'package:financialkeeper/services/firebase_service.dart';
import 'package:financialkeeper/core/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/goal_model.dart';
import '../models/contribution_model.dart';
import '../core/theme/app_colors.dart';

class GoalController extends GetxController {
  final FirebaseService firebaseService = FirebaseService();
  var isLoading = true.obs;

  var goals = <GoalModel>[].obs;
  var currentIndex = 0.obs;
  var contributions = <ContributionModel>[].obs;
  var selectedDate = Rxn<DateTime>();

  // UI State for New Flow
  var currentGoalIndex = 0.obs;
  var scrollOffset = 0.0.obs;

  // Input Controllers (Persistent State)
  final TextEditingController goalTitleController = TextEditingController();
  final TextEditingController goalAmountController = TextEditingController();
  final TextEditingController contributionAmountController =
      TextEditingController();
  final TextEditingController contributionNoteController =
      TextEditingController();
  final TextEditingController editAmountController = TextEditingController();
  final TextEditingController editNoteController = TextEditingController();

  // Focus Nodes (Control Flow)
  final FocusNode goalTitleFocus = FocusNode();
  final FocusNode goalAmountFocus = FocusNode();
  final FocusNode contributionAmountFocus = FocusNode();
  final FocusNode contributionNoteFocus = FocusNode();
  final FocusNode editAmountFocus = FocusNode();
  final FocusNode editNoteFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
    listenToGoals();
  }

  @override
  void onClose() {
    goalTitleController.dispose();
    goalAmountController.dispose();
    contributionAmountController.dispose();
    contributionNoteController.dispose();
    goalTitleFocus.dispose();
    goalAmountFocus.dispose();
    contributionAmountFocus.dispose();
    contributionNoteFocus.dispose();
    // editAmountController.dispose();
    // editNoteController.dispose();
    // editAmountFocus.dispose();
    // editNoteFocus.dispose();
    super.onClose();
  }

  void clearGoalInputs() {
    goalTitleController.clear();
    goalAmountController.clear();
    selectedDate.value = null;
  }

  void clearContributionInputs() {
    contributionAmountController.clear();
    contributionNoteController.clear();
  }

  GoalModel? get currentGoal {
    if (goals.isEmpty || currentGoalIndex.value >= goals.length) return null;
    return goals[currentGoalIndex.value];
  }

  void goToGoal(int index) {
    if (index >= 0 && index < goals.length) {
      currentGoalIndex.value = index;
      listenToContributions(goals[index].id);
    }
  }

  void nextGoal() {
    if (currentGoalIndex.value < goals.length - 1) {
      goToGoal(currentGoalIndex.value + 1);
    }
  }

  void previousGoal() {
    if (currentGoalIndex.value > 0) {
      goToGoal(currentGoalIndex.value - 1);
    }
  }

  void updateScrollOffset(double val) {
    scrollOffset.value = val;
  }

  void listenToGoals() {
    firebaseService.getGoals().listen((data) {
      goals.value = data;
      isLoading.value = false;
      if (data.isNotEmpty && currentGoalIndex.value < data.length) {
        listenToContributions(data[currentGoalIndex.value].id);
      }
    });
  }

  void onGoalChanged(int index) {
    goToGoal(index);
  }

  void listenToContributions(String goalId) {
    firebaseService.getContributions(goalId).listen((data) {
      contributions.value = data;
    });
  }

  double get progress {
    final goal = currentGoal;
    if (goal == null || goal.targetAmount == 0) return 0;
    return goal.savedAmount / goal.targetAmount;
  }

  double get remainingAmount {
    final goal = currentGoal;
    if (goal == null) return 0;
    return (goal.targetAmount - goal.savedAmount).clamp(0, double.infinity);
  }

  double calculateMonthlyProjection(GoalModel goal) {
    final daysLeft = goal.deadline.difference(DateTime.now()).inDays;
    if (daysLeft <= 0) return 0;
    final monthsLeft = (daysLeft / 30).ceil();
    final remaining =
        (goal.targetAmount - goal.savedAmount).clamp(0.0, double.infinity);
    if (monthsLeft <= 0) return remaining;
    return remaining / monthsLeft;
  }

  bool createGoal(String title, double amount, DateTime deadline) {
    if (amount <= 0) {
      showErrorSnackbar("Invalid amount");
      return false;
    }
    firebaseService.createGoal(title, amount, deadline);
    clearGoalInputs();
    return true;
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  bool addContribution(double amount, String note) {
    final goal = currentGoal;
    if (goal == null) return false;

    if (amount <= 0) {
      showErrorSnackbar("Amount must be greater than 0");
      return false;
    }
    if ((goal.savedAmount + amount) > goal.targetAmount) {
      showErrorSnackbar("Contribution exceeds remaining target amount");
      return false;
    }
    firebaseService.addContribution(goal.id, amount, note);
    clearContributionInputs();
    return true;
  }

  bool updateContribution(
      ContributionModel contribution, double newAmount, String newNote) {
    final goal = currentGoal;
    if (goal == null) return false;

    if (newAmount <= 0) {
      showErrorSnackbar("Amount must be greater than 0");
      return false;
    }
    if ((goal.savedAmount - contribution.amount + newAmount) >
        goal.targetAmount) {
      showErrorSnackbar("Update exceeds remaining target amount");
      return false;
    }
    firebaseService.updateContribution(
        goal.id, contribution.id, contribution.amount, newAmount, newNote);
    return true;
  }

  void deleteContribution(ContributionModel contribution) {
    final goal = currentGoal;
    if (goal == null) return;
    firebaseService.deleteContribution(
        goal.id, contribution.id, contribution.amount);
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      "Action Failed",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error.withOpacity(0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 10,
    );
  }

  String calculateMonthlySuggestionForGoal(GoalModel goal) {
    final daysLeft = goal.deadline.difference(DateTime.now()).inDays;
    if (daysLeft <= 0) return "Deadline reached";

    final monthsLeft = (daysLeft / 30).ceil();
    final remaining = goal.targetAmount - goal.savedAmount;

    if (remaining <= 0) {
      return "Goal achieved!";
    }

    final deadlineText =
        "${goal.deadline.day}/${goal.deadline.month}/${goal.deadline.year}";

    if (monthsLeft <= 3) {
      final weeksLeft = (daysLeft / 7).ceil();
      final perWeek = remaining / (weeksLeft > 0 ? weeksLeft : 1);
      return "Save ${Formatter.currency(perWeek)}/week till $deadlineText";
    }

    final perMonth = remaining / (monthsLeft > 0 ? monthsLeft : 1);
    return "Save ${Formatter.currency(perMonth)}/month for $monthsLeft months";
  }
}
