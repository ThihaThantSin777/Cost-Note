import 'package:costnotebook/bloc/home_page_bloc.dart';
import 'package:costnotebook/data/vos/group_by_vo/group_by_vo.dart';
import 'package:costnotebook/page/add_cost_page.dart';
import 'package:costnotebook/page/bar_charts_page.dart';
import 'package:costnotebook/resources/dimension.dart';
import 'package:costnotebook/resources/strings.dart';
import 'package:costnotebook/utils/extensions.dart';
import 'package:costnotebook/view_items/home_page_item_view.dart';
import 'package:costnotebook/widgets/date_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigatePush(context, AddCostPage()),
          child: const Icon(Icons.note_add, color: Colors.white),
        ),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              navigatePush(context, const BarChartsPage());
            }, icon: const Icon(Icons.bar_chart,color: Colors.white,))
          ],
          title: const Text(kAppName),
        ),
        body: Selector<HomePageBloc,List<GroupByVO>?>(
          selector: (context,bloc)=>bloc.getGroupByVOList,
          builder: (context,groupByList,child){
            int length=groupByList?.length??0;
            if((groupByList?.isEmpty??true) || groupByList==null){
              return Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                child: const Text(kEmptyText),
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: kSpaceAndPadding5X,
                    ),
                    Expanded(child: Selector<HomePageBloc,DateTime?>(
                        selector: (context,bloc)=>bloc.getStartDate,
                        builder: (context,firstDate,child){
                          HomePageBloc homePageBloc=context.read<HomePageBloc>();
                          return DateButtonWidget(
                            dateTime: firstDate??DateTime.now(),
                            onPressed: (){
                              showDate(firstDate??DateTime.now(), context,homePageBloc.getFirstDate??DateTime.now(),homePageBloc.getEndDate??DateTime.now()).then((value) {
                                if(value!=null){
                                  homePageBloc.setFirstDate(value);
                                }
                              });
                            },
                          );
                        }

                    )
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: kSpaceAndPadding10X,
                      child: const Text('-',style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),),
                    ),
                    Expanded(child: Selector<HomePageBloc,DateTime?>(
                        selector: (context,bloc)=>bloc.getEndDate,
                        builder: (context,endDate,child){
                          HomePageBloc homePageBloc=context.read<HomePageBloc>();
                          return    DateButtonWidget(
                            dateTime: endDate??DateTime.now(),
                            onPressed: (){
                              showDate(endDate??DateTime.now(), context,homePageBloc.getStartDate??DateTime.now(),DateTime.now()).then((value) {
                                if(value!=null){
                                  homePageBloc.setEndDate(value);
                                }
                              });
                            },
                          );
                        }

                    )
                    ),
                    const SizedBox(
                      width: kSpaceAndPadding5X,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: kSpaceAndPadding5X,
                                      child: Padding(
                                          padding: const EdgeInsets.all(
                                              kSpaceAndPadding5X),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                groupByList[index].key,
                                                style: const TextStyle(
                                                    fontSize: kFontSize19x,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: kSpaceAndPadding5X,
                                              ),
                                              CostBodyItemView(
                                                addCostVoList:
                                                groupByList[index]
                                                    .addCostVOList,
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: kSpaceAndPadding10X,
                                  ),
                                  itemCount: length),
                            ),
                          ],
                        ),
                ),
              ],
            );
          }

        ),
      ),
    );
  }
}


