//used for color schemes and decorations
import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  isDense: true,
  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 5.0, 15.0),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2.0,
      )),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    //when clicked
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);

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
  
    gradient: RadialGradient(
      colors: [Colors.purple, Colors.white],
      radius: 12,
    ),
    //color: Theme.of(context).colorScheme.primary
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      BoxShadow(
          offset: Offset(1, 1),
          blurRadius: 5,
          spreadRadius: 5.0,
          blurStyle: BlurStyle.normal)
    ],
    border: Border.symmetric());
