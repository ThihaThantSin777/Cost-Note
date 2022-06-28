import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';
import 'package:costnotebook/data/vos/bar_chart_vo/bar_chart_vo.dart';
import 'package:costnotebook/data/vos/group_by_vo/group_by_vo.dart';
import 'package:costnotebook/persistent/cost_dao.dart';
import 'package:costnotebook/persistent/hive_constant/hive_constant.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:collection/collection.dart";
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;


class CostDAOImpl extends CostDAO {

  CostDAOImpl._internal();

  static final CostDAOImpl _singleton = CostDAOImpl._internal();

  factory CostDAOImpl()=> _singleton;

  @override
  List<GroupByVO>? getCosts() {
    List<AddCostVo>temp1=_getBox().values.toList().reversed.toList();
    var newMap = groupBy(temp1, (AddCostVo addCostVo) {
      return addCostVo.date;
    });
    List<GroupByVO>temp=[];
    newMap.forEach((key, value) {
      GroupByVO groupByVO=GroupByVO(key: key??'', addCostVOList: value);
      temp.add(groupByVO);
    });
    return temp;
  }

  @override
  void save(AddCostVo addCostVo) =>_getBox().put(addCostVo.id.toString(), addCostVo);

  @override
  Stream getCostEvent() =>_getBox().watch();

  @override
  Stream<List<GroupByVO>?> getCostStream()=>Stream.value(getCosts());

  Box<AddCostVo>_getBox()=>Hive.box<AddCostVo>(kBoxNameForAddCost);

  @override
  DateTime ? getFirstDate() {
   List<AddCostVo> ? addCostVo= _getBox().values.toList();
   if(addCostVo.isNotEmpty){
     return addCostVo.first.id;
   }
   return null;
  }


  @override
  List<GroupByVO>? getCostsByDate(DateTime firstDate, DateTime endDate) {
    List<AddCostVo>temp1= _getBox().values.toList().where((element) {
      return (element.id?.isAfter(firstDate)??false) && (element.id?.isBefore(endDate)??false);
    }).toList().reversed.toList();

    var newMap = groupBy(temp1, (AddCostVo addCostVo) {
      return addCostVo.date;
    });

    List<GroupByVO>temp=[];
    newMap.forEach((key, value) {
      GroupByVO groupByVO=GroupByVO(key: key??'', addCostVOList: value);
      temp.add(groupByVO);
    });
    return temp;
  }

  @override
  Stream<List<GroupByVO>?> getCostsStreamByDate(DateTime firstDate, DateTime endDate) =>Stream.value(getCostsByDate(firstDate, endDate));

  @override
  List<BarChartVO>? getBarChartsList(DateTime firstDate, DateTime endDate) {
   List<GroupByVO>?temp=getCostsByDate(firstDate, endDate);
   if(temp?.isNotEmpty??false){
     List<BarChartVO>?barChatList=[];
     math.Random random=math.Random();
     temp?.forEach((data) {
       int red=1+random.nextInt(255);
       int green=1+random.nextInt(255);
       int blue=1+random.nextInt(255);
       String date=data.key;
       String totalAmount=data.addCostVOList.map((e) => double.parse(e.costAmount??'0')).reduce((value, element) => value+element).toString();
       BarChartVO barChartVO=BarChartVO(date: date, totalAmount: totalAmount,color: charts.ColorUtil.fromDartColor(Color.fromRGBO(red, green, blue, 1.0)));
       barChatList.add(barChartVO);
     });
     return barChatList;
   }
   return [];
  }

  @override
  Stream<List<BarChartVO>?> getBarChartsListStream(DateTime firstDate, DateTime endDate) =>Stream.value(getBarChartsList(firstDate, endDate));

}