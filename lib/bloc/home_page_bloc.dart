import 'package:costnotebook/data/model/cost_model.dart';
import 'package:costnotebook/data/model/cost_model_impl.dart';
import 'package:flutter/material.dart';

import '../data/vos/group_by_vo/group_by_vo.dart';

class HomePageBloc with ChangeNotifier{
  bool _isDisposed=false;
  DateTime? _firstDate=DateTime.now();
  DateTime? _startDate=DateTime.now();
  DateTime? _endDate=DateTime.now();
  List<GroupByVO>?_groupByVOList;

  DateTime ? get getFirstDate=>_firstDate;
  DateTime ? get getEndDate=>_endDate;
  DateTime ? get getStartDate=>_startDate;
  List<GroupByVO>? get getGroupByVOList=>_groupByVOList;


  final CostModel _costModel=CostModelImpl();
  HomePageBloc(){
    if(_costModel.getFirstDate()!=null){
      _firstDate=_costModel.getFirstDate();
      _startDate=_firstDate;
      _endDate=DateTime.now();
      _costModel.getCostStream().listen((data) {
        if(data?.isEmpty??true){
          _groupByVOList=[];
        }else{
          _groupByVOList=data;
        }
        _notifySafely();
      });
    }

  }

  void setFirstDate(DateTime dateTime){
    _startDate=dateTime;
    _notifySafely();
    List<GroupByVO>? temp= _costModel.getCostsByDate(_startDate!, _endDate!);
    if(temp?.isEmpty??true){
      _groupByVOList=[];
    }else{
      _groupByVOList=temp;
    }

    _notifySafely();
  }

  void setEndDate(DateTime dateTime){
    _endDate=dateTime;
    _notifySafely();
    List<GroupByVO>? temp= _costModel.getCostsByDate(_startDate!, _endDate!.add(const Duration(days: 1)));
    if(temp?.isEmpty??true){
      _groupByVOList=[];
    }else{
      _groupByVOList=temp;
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