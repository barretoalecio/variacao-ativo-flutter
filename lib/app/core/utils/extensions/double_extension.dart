import 'package:intl/intl.dart';

extension DoubleExtension on double {
  static List<double> convertDoubleListMapToDoubleList(List valuesListMap) {
    List<double> values = List.castFrom<dynamic, double>(valuesListMap);

    return List<double>.from(values).map((value) => value.toDouble()).toList();
  }

  String toCurrency() {
    final currencyFormatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return currencyFormatter.format(this);
  }

  double getDifferenceBeetweenDays(double value) {
    double previousValue = value * 100;
    return 100 - previousValue / this;
  }
}