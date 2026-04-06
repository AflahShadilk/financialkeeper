import 'package:cloud_firestore/cloud_firestore.dart';

class GoalModel {
  final String id;
  final String title;
  final double savedAmount;
  final double targetAmount;
  final DateTime deadline;

  GoalModel({
    required this.id,
    required this.title,
    required this.savedAmount,
    required this.targetAmount,
    required this.deadline,
  });

  double get percentComplete => targetAmount == 0 ? 0 : savedAmount / targetAmount;

  factory GoalModel.fromJson(String id, Map<String, dynamic> json) {
    return GoalModel(
      id: id,
      title: json['title'] ?? '',
      savedAmount: (json['savedAmount'] as num?)?.toDouble() ?? 0.0,
      targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0.0,
      deadline: (json['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'savedAmount': savedAmount,
      'targetAmount': targetAmount,
      'deadline': Timestamp.fromDate(deadline),
    };
  }
}