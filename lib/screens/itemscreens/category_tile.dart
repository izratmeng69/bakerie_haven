//import 'package:bakerie_haven/shared/constants.dart';
import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:bakerie_haven/screens/itemscreens/product_tile.dart';
import 'package:bakerie_haven/models/streams.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:bakerie_haven/Services/firebase_api_storage.dart';
import 'package:bakerie_haven/models/firebase_file.dart';
import 'package:bakerie_haven/screens/itemscreens/image_page.dart';
import 'package:bakerie_haven/shared/constants.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io'
    as io; // for File? class, filepicker- apparently it supports all devices now
import 'package:path/path.dart'; //needed for basename, file picker
import 'dart:async';
//import 'dart:html'; //hide File;
import 'dart:typed_data';

class CatTile extends StatefulWidget {
  const CatTile({super.key});

  @override
  State<CatTile> createState() => _CatTileState();
}

class _CatTileState extends State<CatTile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}