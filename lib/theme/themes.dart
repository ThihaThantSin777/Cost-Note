import 'package:flutter/material.dart';

class Themes{
  static final ThemeData themeData=ThemeData(
    primarySwatch: Colors.red,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(secondary: Colors.redAccent),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        color: Colors.black,
      )
    )
  );
}