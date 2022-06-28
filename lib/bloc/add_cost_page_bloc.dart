import 'package:costnotebook/data/model/cost_model.dart';
import 'package:costnotebook/data/model/cost_model_impl.dart';
import 'package:flutter/material.dart';

import '../data/vos/add_cost_vo/add_cost_vo.dart';

class AddCostPageBloc with ChangeNotifier{
  bool _isDisposed=false;

  List<AddCostVo>_addCostVoListTemp=[];
  AddCostVo? _tempAddCostVO;
  final TextEditingController _title=TextEditingController();
  final TextEditingController _amount=TextEditingController();
  final TextEditingController _note=TextEditingController();
  final ScrollController _scrollController=ScrollController();
  bool _loading=false;


  TextEditingController get getTitle=>_title;
  TextEditingController get getAmount=>_amount;
  TextEditingController get getNote=>_note;
  ScrollController get getScrollController=>_scrollController;
  bool get isLoading=>_loading;
  List<AddCostVo> get getAddCostVOListTemp=>_addCostVoListTemp;

  final CostModel _costModel=CostModelImpl();

  Future save(){
    _loading=true;
    _notifySafely();
    for (var addCostVo in _addCostVoListTemp) {
      addCostVo.id=DateTime.now();
      addCostVo.date='${addCostVo.id?.day}/${addCostVo.id?.month}/${addCostVo.id?.year}';
      _costModel.save(addCostVo);
    }
    _loading=false;
    _notifySafely();
    return Future.value('');
  }
  void tempEdit(AddCostVo addCostVo){
    _title.text=addCostVo.costTitle??'';
    _amount.text=addCostVo.costAmount??'';
    _note.text=addCostVo.costNote??'';
    _tempAddCostVO=addCostVo;
    _notifySafely();
  }

  void tempDelete(AddCostVo addCostVo){
    _tempAddCostVO==null;
    _addCostVoListTemp.remove(addCostVo);
    _addCostVoListTemp=_addCostVoListTemp.map((e) => e).toList();
    _notifySafely();
  }
  void tempSave(){
    DateTime tempID=DateTime.now();
    String costTitle=_title.text;
    String costAmount=_amount.text;
    String costNote=_note.text;
    String date='${tempID.day}/${tempID.month}/${tempID.year}';
    _title.clear();
    _amount.clear();
    _note.clear();
    AddCostVo addCostVo=AddCostVo(id: tempID, costTitle: costTitle, costAmount: costAmount, costNote: costNote,date: date);
   if(_tempAddCostVO==null){
     _addCostVoListTemp.add(addCostVo);
    if(_addCostVoListTemp.length>1){
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.ease);
    }
   }else{
      for(int i=0;i<_addCostVoListTemp.length;i++){
        if(_addCostVoListTemp[i]==_tempAddCostVO){
          _addCostVoListTemp[i]=addCostVo;
        }
      }
      _tempAddCostVO=null;
   }
    _addCostVoListTemp=_addCostVoListTemp.map((e) => e).toList();
    _notifySafely();

  }
  void changeTextTitle(String text){
    _title.text=text;
    _title.selection = TextSelection.fromPosition(TextPosition(offset: _title.text.length));
    _notifySafely();
  }

  void changeTextAmount(String text){
    _amount.text=text;
    _amount.selection = TextSelection.fromPosition(TextPosition(offset: _amount.text.length));
    _notifySafely();
  }

  void changeTextNoted(String text){
    _note.text=text;
    _note.selection = TextSelection.fromPosition(TextPosition(offset: _note.text.length));

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
    _title.dispose();
    _amount.dispose();
    _note.dispose();
    _scrollController.dispose();
    _isDisposed=true;
  }

}