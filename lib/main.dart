import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';
import 'package:costnotebook/page/home_page.dart';
import 'package:costnotebook/persistent/cost_dao_impl.dart';
import 'package:costnotebook/persistent/hive_constant/hive_constant.dart';
import 'package:costnotebook/resources/strings.dart';
import 'package:costnotebook/theme/themes.dart';
import 'package:flutter/material.dart' ;
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  await Hive.initFlutter();

  Hive.registerAdapter(AddCostVoAdapter());

  await Hive.openBox<AddCostVo>(kBoxNameForAddCost);

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: Themes.themeData,
        title: kAppName,
        debugShowCheckedModeBanner: false,
        home:  const HomePage()
    );
  }
}






