

import 'dart:ui';

import 'package:flutter/material.dart';

class GlobalColor{
  static Color title = Color(0xff1d00bd);
  static Color darkTitle = Color(0x961d00bd);
  static Color subtitle = Color(0xff4a35bb);
  static Color soft = Color(0xff9585ff);
  static Color softDeep = Color(0xff7b63ff);
  static Color text = Colors.black54;
  static LinearGradient mainLinear = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,colors: [Color(0xff7055f8), Color(0xff4e00a2)]);
  static LinearGradient softLinear = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,colors: [Color(0xff694dff), Color(0xffbfb2ff)]);
}