import 'package:cloud_firestore/cloud_firestore.dart';

class GoalModel {
  final String title;
  final double savedAmount;
  final double targetAmount;
  final DateTime deadline;
  GoalModel({
    required this.title,
    required this.savedAmount,
    required this.targetAmount,
    required this.deadline,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      title: json['title'],
      savedAmount: (json['savedAmount']as num).toDouble(),
      targetAmount: (json['targetAmount']as num).toDouble(),
      deadline: (json['deadline'] as Timestamp).toDate(),
    );
  }
}