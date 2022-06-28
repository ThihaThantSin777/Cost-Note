import 'package:charts_flutter/flutter.dart' as charts;
class BarChartVO {
  String date;
  String totalAmount;
  charts.Color color;

  BarChartVO({required this.date, required this.totalAmount, required this.color});

  @override
  String toString() {
    return 'BarChartVO{date: $date, totalAmount: $totalAmount, color: $color}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarChartVO &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          totalAmount == other.totalAmount &&
          color == other.color;

  @override
  int get hashCode => date.hashCode ^ totalAmount.hashCode ^ color.hashCode;
}