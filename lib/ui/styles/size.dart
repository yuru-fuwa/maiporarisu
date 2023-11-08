import 'dart:math';

import 'package:flutter/material.dart';

class MaiporarisuSize {
  static const double sheetMinHeight = 152;
  static const double sheetHandleHeight = 77;

  static double minMapHeight(BuildContext context) {
    return min(MediaQuery.of(context).size.height / 2, 320);
  }

  static double defaultSheetHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return sheetMinHeight / screenHeight;
  }
}
