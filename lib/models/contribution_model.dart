import 'package:cloud_firestore/cloud_firestore.dart';

class ContributionModel {
  final double amount;
  final DateTime date;

  ContributionModel({
    required this.amount,
    required this.date,
  });

  factory ContributionModel.fromJson(Map<String, dynamic> json) {
    return ContributionModel(
      amount: (json['amount'] as num).toDouble(),
      date: (json['date'] as Timestamp).toDate(),
    );
  }
}
