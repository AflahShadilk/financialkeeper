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
  void createGoal(String title, double amount) {
    _firebaseService.createGoal(title, amount);
  }


  /// contribution related -----------------------------
  //contribution listening
  void listenToContributions() {
    _firebaseService.getContributions().listen((data) {
      contributions.value = data;
    });
  }

 //add contribution
  void addContribution(double amount) {
    _firebaseService.addContribution(amount);
  }
  //update contribution
  void updateContribution(ContributionModel contribution, double newAmount) {
    _firebaseService.updateContribution(contribution.id, contribution.amount, newAmount);
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
    final goalData= goal.value!;
    final daysLeft= goalData.deadline.difference(DateTime.now()).inDays;
    if(daysLeft<=0) return "Deadline reached";
    final monthsLeft = daysLeft~/ 30;

    if (monthsLeft <= 0) return "Deadline reached";

    final remainingAmount = goalData.targetAmount - goalData.savedAmount;
    if(remainingAmount<=0) return "Goal achieved! You can stop contributing to this.";
    final perMonth = remainingAmount / monthsLeft;
    return "Save ₹${perMonth.toStringAsFixed(0)}/month to reach your goal";
  }
}
