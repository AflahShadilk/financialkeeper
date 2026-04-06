import 'package:cloud_firestore/cloud_firestore.dart';

enum ContributionType { salary, extra, bonus }

class ContributionModel {
  final String id;
  final double amount;
  final DateTime date;
  final String note;
  final ContributionType type;

  ContributionModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.note,
    required this.type,
  });

  factory ContributionModel.fromJson(String id, Map<String, dynamic> json) {
    final typeStr = json['type'] ?? 'extra';
    final type = ContributionType.values.firstWhere(
      (e) => e.name == typeStr,
      orElse: () => ContributionType.extra,
    );

    return ContributionModel(
      id: id,
      amount: (json['amount'] as num).toDouble(),
      date: (json['date'] as Timestamp).toDate(),
      note: json['note'] ?? '',
      type: type,
    );
  }
}
