import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

final real = Currency.create('Real', 2,
    symbol: 'R\$', invertSeparators: true, pattern: 'S #.##0,00');

class Utils {
  static formatarValor(double valor) =>
      Money.fromNumWithCurrency(valor, real).toString();
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
