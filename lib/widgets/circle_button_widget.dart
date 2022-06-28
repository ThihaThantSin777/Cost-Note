

import 'package:costnotebook/resources/dimension.dart';
import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({Key? key,required this.onPressed,required this.child}): super(key: key);
  final Function onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(kSpaceAndPadding10X),
       ),
        backgroundColor: Theme.of(context).primaryColor
      ),
        onPressed: ()=>onPressed(), child: child
    );
  }
}
