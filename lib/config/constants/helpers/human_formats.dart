import 'package:intl/intl.dart';

import '../app_constants.dart';

class HumanFormats {
  static String number(double number, [int decimals = 0]) {
    return NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: "", locale: "en")
        .format(number);
  }

  static String currentDay() {
    return DateFormat("MMMM d" ,AppConstants.language).format(DateTime.now()).capitalize();
  }

  static String shortDate( DateTime date ) {
    return DateFormat("MMMM d, yyyy" ,AppConstants.language).format(date).capitalize();
  }

}
  
extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
