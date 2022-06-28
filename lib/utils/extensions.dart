import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NavigateonStatelessWidget on Widget {
  Future<bool?> showMyDialog(BuildContext context,String text) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?>showDate(DateTime dateTime,BuildContext context,DateTime firstDate,DateTime lastDate){
    return showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: firstDate,
        lastDate: lastDate
    );
  }

  Future navigatePush(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).push(_createRoute(nextScreen));

  Route _createRoute(Widget nextScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void navigateBack(BuildContext context) => Navigator.of(context).pop();
}

extension Format on String {
  String formatDigit() => NumberFormat('#,##,000').format(double.parse(this));
}


