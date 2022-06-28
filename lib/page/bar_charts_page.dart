
import 'package:costnotebook/bloc/bar_charts_page_bloc.dart';
import 'package:costnotebook/resources/dimension.dart';
import 'package:costnotebook/resources/strings.dart';
import 'package:costnotebook/utils/extensions.dart';
import 'package:costnotebook/widgets/date_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../data/vos/bar_chart_vo/bar_chart_vo.dart';

class BarChartsPage extends StatelessWidget {
  const BarChartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BarChartsPageBloc>(
      create: (context)=>BarChartsPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(kBarChartsAndTotal),
        ),
        body: Selector<BarChartsPageBloc,List<BarChartVO> ?>(
          shouldRebuild: (pre,next)=>pre!=next,
          selector: (context,bloc)=>bloc.getBarChartList,
          builder: (context,data,child){
            if(data?.isEmpty??true){
              return Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                child: const Text(kEmptyText),
              );
            }
            List<charts.Series<BarChartVO,String>>  series=[
              charts.Series(
                data: data??[],
                domainFn: (BarChartVO barchart,_)=>'${barchart.date}(Total: ${barchart.totalAmount.formatDigit()})',
                measureFn: (BarChartVO barchart,_)=>double.parse(barchart.totalAmount),
                colorFn: (BarChartVO barchart,_)=>barchart.color,
                id: 'Daily Task',
              )
            ];
            return Column(
              children: [
                Expanded(
                  flex: kFlexRate3x,
                  child:  charts.BarChart(
                          series,
                          animate: true,
                          animationDuration: const Duration(seconds: 1),

                        ),

                ),
                Expanded(
                  child:  Row(
                    children: [
                      const SizedBox(
                        width: kSpaceAndPadding5X,
                      ),
                      Expanded(child: Selector<BarChartsPageBloc,DateTime?>(
                          selector: (context,bloc)=>bloc.getStartDate,
                          builder: (context,firstDate,child){
                            BarChartsPageBloc homePageBloc=context.read<BarChartsPageBloc>();
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
                      Expanded(child: Selector<BarChartsPageBloc,DateTime?>(
                          selector: (context,bloc)=>bloc.getEndDate,
                          builder: (context,endDate,child){
                            BarChartsPageBloc homePageBloc=context.read<BarChartsPageBloc>();
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
                )
              ],
            );
          }

        ),
      ),
    );
  }
}
