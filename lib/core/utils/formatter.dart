import 'package:intl/intl.dart';

class Formatter {
  static String currency(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,

    ).format(amount);
  }

  static String compactCurrency(double amount) {
    return NumberFormat.compactCurrency(
      locale: 'en_IN',
      symbol: '₹',
    ).format(amount);
  }
}