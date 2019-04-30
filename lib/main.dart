import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';// show debugPaintSizeEnabled;
import 'package:udb_easy_life/common/Home.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MaterialApp(
    title: 'UDB Easy life',
    home: Home(),
  ));
}
