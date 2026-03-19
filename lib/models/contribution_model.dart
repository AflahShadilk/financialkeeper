import 'package:cloud_firestore/cloud_firestore.dart';

class ContributionModel {
  final String id;
  final double amount;
  final DateTime date;

  ContributionModel({
    required this.id,
    required this.amount,
    required this.date,
  });

  factory ContributionModel.fromJson(String id,Map<String, dynamic> json) {
    return ContributionModel(
      id: id,
      amount: (json['amount'] as num).toDouble(),
      date: (json['date'] as Timestamp).toDate(),
    );
  }
}
