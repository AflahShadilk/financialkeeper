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
      date: DateTime.parse(json['date']),
    );
  }
}
