import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey,
    primarySwatch: Colors.pink, //textbutton color
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    //darkness: Brightness.light
    primaryColor:
        Colors.lightBlue[800], //Color(0XFF673f45), //Colors.lightBlue[800],

    // Define the default font family.
    fontFamily: 'Georgia',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 12.0,
          fontWeight: FontWeight.bold),
      headline6: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16.0,
          fontStyle: FontStyle.italic),
      bodyText2: TextStyle(
          color: Colors.pinkAccent, fontSize: 14.0, fontFamily: 'Georgia'),
    ),
  );
}
