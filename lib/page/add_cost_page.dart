import 'package:costnotebook/bloc/add_cost_page_bloc.dart';
import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';
import 'package:costnotebook/resources/dimension.dart';
import 'package:costnotebook/resources/strings.dart';
import 'package:costnotebook/utils/extensions.dart';
import 'package:costnotebook/view_items/add_cost_page_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCostPage extends StatelessWidget {
  AddCostPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  void editOrDelete(BuildContext context,AddCostVo addCostVo,AddCostPageBloc addCostPageBloc){
    showModalBottomSheet(context: context, builder: (context){
      return SizedBox(
        height: MediaQuery.of(context).size.height*0.15,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: (){
                  navigateBack(context);
                  addCostPageBloc.tempEdit(addCostVo);
                },
                leading: const Icon(Icons.edit,color: Colors.black,size: kEditDeleteIconSize,),
                title: const Text(kEditText),
                trailing: const Icon(Icons.note_alt_outlined,color: Colors.black,),
              ),
              ListTile(
                onTap: (){
                  navigateBack(context);
                 showMyDialog(context, kConformationDeleteText).then((value) {
                   if(value??false){
                     addCostPageBloc.tempDelete(addCostVo);
                   }
                 });
                },
                leading: const Icon(Icons.delete,color: Colors.black,size: kEditDeleteIconSize,),
                title: const Text(kDeleteText),
                trailing: const Icon(Icons.note_alt_outlined,color: Colors.black,),
              ),
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddCostPageBloc>(
      create: (context) => AddCostPageBloc(),
      child: Selector<AddCostPageBloc, List<AddCostVo>>(
          shouldRebuild: (pre, next) => pre != next,
          selector: (context, bloc) => bloc.getAddCostVOListTemp,
          builder: (context, isDefault, child) {
            AddCostPageBloc addCostPageBloc = context.read<AddCostPageBloc>();
            return Stack(
              children: [
                Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
    if (formKey.currentState?.validate() ?? false) {
      addCostPageBloc.tempSave();
    }
                      },
                      child: const Icon(Icons.save),
                    ),
                    appBar: AppBar(
                      actions: [
                        (isDefault.isEmpty)?Container():  IconButton(onPressed: () {

                            showMyDialog(context, kConformationSaveText).then((value) {
                              if(value??false){
                                addCostPageBloc.save().then((value) {
                                  navigateBack(context);
                                });
                              }
                            });


                        }, icon: const Icon(Icons.check))
                      ],
                      title: const Text(kAddCostName),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                            child: Card(
                                elevation: kSpaceAndPadding10X,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: kSpaceAndPadding5X,
                                    vertical: kSpaceAndPadding5X),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kSpaceAndPadding5X,
                                        vertical: kSpaceAndPadding5X),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Selector<AddCostPageBloc,
                                                      TextEditingController>(
                                                  selector: (context, bloc) =>
                                                      bloc.getTitle,
                                                  builder: (context,
                                                      titleController, child) {
                                                    AddCostPageBloc
                                                        addCostPageBloc =
                                                        context.read<
                                                            AddCostPageBloc>();
                                                    return CostTitleItemView(
                                                      onChangeForTitle: (text) {
                                                        addCostPageBloc
                                                            .changeTextTitle(text);
                                                      },
                                                      titleController:
                                                          titleController,
                                                    );
                                                  }),
                                              const SizedBox(
                                                width: kSpaceAndPadding10X,
                                              ),
                                              Selector<AddCostPageBloc,
                                                      TextEditingController>(
                                                  selector: (context, bloc) =>
                                                      bloc.getAmount,
                                                  builder: (context,
                                                      amountController, child) {
                                                    AddCostPageBloc
                                                        addCostPageBloc =
                                                        context.read<
                                                            AddCostPageBloc>();
                                                    return CostAmountItemView(
                                                      amountController:
                                                          amountController,
                                                      onChangeForAmount: (text) {
                                                        addCostPageBloc
                                                            .changeTextAmount(text);
                                                      },
                                                    );
                                                  }),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: kSpaceAndPadding5X,
                                          ),
                                          Selector<AddCostPageBloc,
                                                  TextEditingController>(
                                              selector: (context, bloc) =>
                                                  bloc.getNote,
                                              builder:
                                                  (context, noteController, child) {
                                                AddCostPageBloc addCostPageBloc =
                                                    context.read<AddCostPageBloc>();
                                                return NoteView(
                                                  controllerForNote: noteController,
                                                  onChangeForNote: (text) {
                                                    addCostPageBloc
                                                        .changeTextNoted(text);
                                                  },
                                                );
                                              })
                                        ],
                                      ),
                                    )))),
                        const SizedBox(
                          height: kSpaceAndPadding10X,
                        ),
                        Expanded(
                            flex: 2,
                            child: Selector<AddCostPageBloc, List<AddCostVo>>(
                                shouldRebuild: (pre, next) => pre != next,
                                selector: (context, bloc) =>
                                    bloc.getAddCostVOListTemp,
                                builder: (context, addCostVoList, child) {
                                  if (addCostVoList.isEmpty) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: const Text(kEmptyText),
                                    );
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const PreviewTitleItemView(),
                                      Selector<AddCostPageBloc,ScrollController>(
                                      selector: (context, bloc) =>
                                      bloc.getScrollController,
                                      builder: (context, scrollController, child)=>
                                        Expanded(
                                          child: ListView.separated(
                                            controller: scrollController,
                                              itemBuilder: (context, index) =>
                                                  TempListItemView(
                                                    onTap: (addCostVO){
                                                      editOrDelete(context,addCostVO,addCostPageBloc);
                                                    },
                                                    addCostVo: addCostVoList[index],
                                                  ),
                                              separatorBuilder: (context, index) =>
                                                  const SizedBox(
                                                    height: kSpaceAndPadding5X,
                                                  ),
                                              itemCount: addCostVoList.length),
                                        ),
                                      )
                                    ],
                                  );
                                })),
                      ],
                    )),
                Positioned.fill(
                  child: Selector<AddCostPageBloc, bool>(
                      selector: (context, bloc) => bloc.isLoading,
                      builder: (context, isLoading, child)=>Visibility(
                          visible: isLoading,
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.7),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                  ),
                )
              ],
            );
          }),
    );
  }
}



