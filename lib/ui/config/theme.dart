import 'package:flutter/material.dart';

final theme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  backgroundColor: Color.fromRGBO(18, 18, 18, 1),
  //backgroundColor: Colors.grey.shade900,
  primaryColor: Color.fromARGB(255, 96, 30, 61),
  accentColor: Colors.amberAccent,
  textTheme: TextTheme(
    headline1: TextStyle(fontWeight: FontWeight.w300, fontSize: 96, letterSpacing: -1.5),
    headline2: TextStyle(fontWeight: FontWeight.w300, fontSize: 60, letterSpacing: -0.5),
    headline3: TextStyle(fontWeight: FontWeight.w400, fontSize: 48, letterSpacing: 0.0),
    headline4: TextStyle(fontWeight: FontWeight.w400, fontSize: 34, letterSpacing: 0.25),
    headline5: TextStyle(fontWeight: FontWeight.w400, fontSize: 24, letterSpacing: 0.0),
    headline6: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, letterSpacing: 0.15),
    subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15),
    subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.1),
    bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
    filled: true,
    hintStyle:
        TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal),
  ),
);
