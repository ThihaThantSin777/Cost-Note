import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';

class GroupByVO{
  String key;
  List<AddCostVo>addCostVOList;

  GroupByVO({required this.key, required this.addCostVOList});

  @override
  String toString() {
    return 'GroupByVO{key: $key, addCostVOList: $addCostVOList}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupByVO &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          addCostVOList == other.addCostVOList;

  @override
  int get hashCode => key.hashCode ^ addCostVOList.hashCode;
}