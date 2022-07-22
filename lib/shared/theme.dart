import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    //secondary:Colors.red,
    primarySwatch: Colors.pink, //textbutton color
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    backgroundColor: Colors.deepPurpleAccent,
    //darkness: Brightness.light
    primaryColor: Color.fromARGB(255, 19, 41, 54),
    secondaryHeaderColor: Colors.indigoAccent,
    //secondaryColor: Color.fromARGB(255, 19, 41, 54),
    //Color(0XFF673f45), //Colors.lightBlue[800],
    chipTheme: ChipThemeData(),
    bottomAppBarColor: Colors.yellowAccent,
    cardTheme: CardTheme(
      //shadowColor: Colors.grey,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(120)),
      elevation: 42,
    ),
    // Define the default font family.
    fontFamily: 'Georgia',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Color.fromARGB(255, 19, 41, 54),
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
