
import 'package:costnotebook/data/model/cost_model.dart';
import 'package:costnotebook/data/model/cost_model_impl.dart';
import 'package:costnotebook/data/vos/bar_chart_vo/bar_chart_vo.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartsPageBloc with ChangeNotifier{
  bool _isDisposed=false;
  DateTime ?_firstDate=DateTime.now();
  DateTime ?_startDate=DateTime.now();
  DateTime ?_endDate=DateTime.now();
  List<BarChartVO>? _barChartsList;


  DateTime ? get getFirstDate=>_firstDate;
  DateTime  ?get getEndDate=>_endDate;
  DateTime ? get getStartDate=>_startDate;
  List<BarChartVO>? get getBarChartList=>_barChartsList;


  final CostModel _costModel=CostModelImpl();
  BarChartsPageBloc(){
    _firstDate=_costModel.getFirstDate();
    _startDate=_firstDate;
    _endDate=DateTime.now();
 if(_startDate!=null && _endDate!=null){
   _costModel.getBarChartsListStream(_startDate!, _endDate!).listen((data) {
     _barChartsList=data?.reversed.toList();
     _notifySafely();
   });
 }
  }

  void setFirstDate(DateTime dateTime){
    _startDate=dateTime;
    _notifySafely();
    List<BarChartVO>? temp= _costModel.getBarChartsList(_startDate!, _endDate!);
    if(temp?.isEmpty??true){
      _barChartsList=[];
    }else{
      _barChartsList=temp?.reversed.toList();
    }
    _notifySafely();
  }

  void setEndDate(DateTime dateTime){
    _endDate=dateTime;
    _notifySafely();
    List<BarChartVO>? temp= _costModel.getBarChartsList(_startDate!, _endDate!.add(const Duration(days: 1)));
    if(temp?.isEmpty??true){
      _barChartsList=[];
    }else{
      _barChartsList=temp?.reversed.toList();
    }
    _notifySafely();
  }
  void _notifySafely(){
    if(!_isDisposed){
      notifyListeners();
    }
  }


  @override
  void dispose(){
    super.dispose();
    _isDisposed=true;
  }
}