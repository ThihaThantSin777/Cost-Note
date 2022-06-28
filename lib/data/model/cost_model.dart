import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';
import 'package:costnotebook/data/vos/bar_chart_vo/bar_chart_vo.dart';
import 'package:costnotebook/data/vos/group_by_vo/group_by_vo.dart';

abstract class CostModel{
  void save(AddCostVo addCostVo);

  Stream<List<GroupByVO>?>getCostStream();

  DateTime ? getFirstDate();

  List<GroupByVO>? getCostsByDate(DateTime firstDate,DateTime endDate);
  Stream<List<GroupByVO>?> getCostsStreamByDate(DateTime firstDate, DateTime endDate);

  List<BarChartVO>?getBarChartsList(DateTime firstDate, DateTime endDate);
  Stream<List<BarChartVO>?> getBarChartsListStream(DateTime firstDate, DateTime endDate);
}