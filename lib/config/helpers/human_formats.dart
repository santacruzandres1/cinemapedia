import 'package:intl/intl.dart';

class HumanFortmat{
  static String number (double number){
    final formaterNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale:'en',
      ).format(number);
    
  return formaterNumber;
  }

}