
import 'package:costnotebook/persistent/hive_constant/hive_constant.dart';
import 'package:hive/hive.dart';

part 'add_cost_vo.g.dart';

@HiveType(typeId: kHiveTypeForAddCost)
class AddCostVo {

  @HiveField(0)
  DateTime ? id;

  @HiveField(1)
  String ?costTitle;

  @HiveField(2)
  String ?costAmount;

  @HiveField(3)
  String ?costNote;

  @HiveField(4)
  String? date;


  AddCostVo(
      {required this.id,
      required this.costTitle,
      required this.costAmount,
      required this.costNote,
      required this.date
      });

  @override
  String toString() {
    return 'AddCostVo{id: $id, costTitle: $costTitle, costAmount: $costAmount, costNote: $costNote, date: $date}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddCostVo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          costTitle == other.costTitle &&
          costAmount == other.costAmount &&
          costNote == other.costNote &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      costTitle.hashCode ^
      costAmount.hashCode ^
      costNote.hashCode ^
      date.hashCode;
}
