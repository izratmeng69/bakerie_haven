//used for color schemes and decorations
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 5.0, 15.0),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    )),
    focusedBorder: OutlineInputBorder(
        //when clicked
        borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    )));

Positioned log = Positioned.fill(
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0D47A1),
          Color(0xFF1976D2),
          Color(0xFF42A5F5),
        ],
      ),
    ),
  ),
);
const boxDecoration = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.all(Radius.circular(2)),
    boxShadow: [
      BoxShadow(
          offset: Offset(1, 1),
          blurRadius: 20,
          spreadRadius: 2.0,
          blurStyle: BlurStyle.outer)
    ],
    border: Border.symmetric());
