


import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';
import 'package:costnotebook/resources/dimension.dart';
import 'package:costnotebook/resources/strings.dart';
import 'package:costnotebook/utils/extensions.dart';
import 'package:costnotebook/widgets/preview_widget.dart';
import 'package:flutter/material.dart';




class NoteView extends StatelessWidget {
  const NoteView({
    Key? key,
    required this.onChangeForNote,
    required this.controllerForNote
  }) : super(key: key);
  final Function(String) onChangeForNote;
  final TextEditingController controllerForNote;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerForNote,
      maxLines: kSpaceAndPadding5X.toInt()+1,
      onChanged: (text)=>onChangeForNote(text),
      decoration: const InputDecoration(
          hintText: kCostNote
      ),
    );
  }
}

class PreviewTitleItemView extends StatelessWidget {
  const PreviewTitleItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.preview_outlined,color: Colors.black,),
        Text(kPreviewText)
      ],
    );
  }
}

class CostAmountItemView extends StatelessWidget {
  const CostAmountItemView({
    Key? key,
    required this.amountController,
    required this.onChangeForAmount
  }) : super(key: key);
  final TextEditingController amountController;
  final Function(String)onChangeForAmount;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  TextFormField(
        controller: amountController,
        keyboardType: TextInputType.number,
        validator: (string){
          if(string?.isEmpty??true){
            return kRequiredText;
          }
          return null;
        },
        onChanged: (text)=>onChangeForAmount(text),
        decoration: const InputDecoration(
            hintText: kCostAmount
        ),
      ),



    );
  }
}

class CostTitleItemView extends StatelessWidget {
  const CostTitleItemView({
    Key? key,
    required this.titleController,
    required this.onChangeForTitle,
  }) : super(key: key);
  final TextEditingController titleController;
  final Function(String)onChangeForTitle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: kFlexRate2x,
      child: TextFormField(
        controller: titleController,
        validator: (string){
          if(string?.isEmpty??true){
            return kRequiredText;
          }
          return null;
        },
        onChanged: (text)=>onChangeForTitle(text),
        decoration: const InputDecoration(
            hintText: kCostTitle
        ),
      ),



    );
  }
}

class TempListItemView extends StatelessWidget {
  const TempListItemView({Key? key, required this.addCostVo,required this.onTap}) : super(key: key);
  final AddCostVo addCostVo;
  final Function(AddCostVo)onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(addCostVo),
      child: Card(
          elevation: kSpaceAndPadding5X,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpaceAndPadding5X),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PreviewWidget(
                  previewTitle: kCostTitle,
                  previewText: addCostVo.costTitle??'',
                ),
                PreviewWidget(
                  previewTitle: kCostAmount,
                  previewText: addCostVo.costAmount??''.formatDigit(),
                ),
                PreviewWidget(
                  previewTitle: kCostNoteWithoutOptional,
                  previewText: addCostVo.costNote??'',
                ),
              ],
            ),
          )),
    );
  }
}