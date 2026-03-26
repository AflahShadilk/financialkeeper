import 'package:intl/intl.dart';

class Formatter {
  static String currency(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,

    ).format(amount);
  }

//   static String compactCurrency(double amount) {
//   if (amount >= 10000000) {
//     return '₹${(amount / 10000000).toStringAsFixed(1)}Cr';
//   } else if (amount >= 100000) {
//     return '₹${(amount / 100000).toStringAsFixed(1)}L';
//   } else if (amount >= 1000) {
//     return '₹${(amount / 1000).toStringAsFixed(1)}K';
//   } else {
//     return '₹${amount.toStringAsFixed(0)}';
//   }
// }
}