import 'package:costnotebook/data/model/cost_model.dart';
import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';
import 'package:costnotebook/data/vos/bar_chart_vo/bar_chart_vo.dart';
import 'package:costnotebook/data/vos/group_by_vo/group_by_vo.dart';
import 'package:costnotebook/persistent/cost_dao.dart';
import 'package:costnotebook/persistent/cost_dao_impl.dart';
import 'package:stream_transform/stream_transform.dart';

class CostModelImpl extends CostModel {
  CostModelImpl._internal();

  static final CostModelImpl _singleton = CostModelImpl._internal();

  factory CostModelImpl() => _singleton;

  final CostDAO _costDAO = CostDAOImpl();

  @override
  Stream<List<GroupByVO>?> getCostStream() => _costDAO
      .getCostEvent()
      .startWith(_costDAO.getCostStream())
      .map((event) => _costDAO.getCosts());

  @override
  void save(AddCostVo addCostVo) => _costDAO.save(addCostVo);

  @override
  DateTime ?getFirstDate() => _costDAO.getFirstDate();

  @override
  List<GroupByVO>? getCostsByDate(DateTime firstDate, DateTime endDate) =>
      _costDAO.getCostsByDate(firstDate, endDate);

  @override
  Stream<List<GroupByVO>?> getCostsStreamByDate(
          DateTime firstDate, DateTime endDate) =>
      _costDAO
          .getCostEvent()
          .startWith(_costDAO.getCostsStreamByDate(firstDate, endDate))
          .map((event) => _costDAO.getCostsByDate(firstDate, endDate));

  @override
  Stream<List<BarChartVO>?> getBarChartsListStream(DateTime firstDate, DateTime endDate) =>_costDAO.getBarChartsListStream(firstDate, endDate);

  @override
  List<BarChartVO>? getBarChartsList(DateTime firstDate, DateTime endDate) =>_costDAO.getBarChartsList(firstDate, endDate);
}
