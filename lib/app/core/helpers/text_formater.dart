import 'package:intl/intl.dart';

class TextFormater {
  static final _formatRealPattern = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');

  TextFormater._();

  static String formatReal(double value) => _formatRealPattern.format(value);
}
