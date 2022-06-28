

import 'package:costnotebook/resources/dimension.dart';
import 'package:flutter/material.dart';

class DateButtonWidget extends StatelessWidget {
  const DateButtonWidget({
    Key? key,
    required this.dateTime,
    required this.onPressed
  }) : super(key: key);
  final DateTime dateTime;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.orange,
      color: Colors.red,

      onPressed: ()=>onPressed(),
      child:  Text('${dateTime.day}/${dateTime.month}/${dateTime.year}',style: const TextStyle(
          fontSize: kFontSize17x,
          color: Colors.white
      ),),
    );
  }
}