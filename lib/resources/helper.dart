import 'dart:math';

import 'package:flutter/material.dart';

class Helper {
  late BuildContext buildContext;
  late DateTime currentBackPressTime;

  Helper.of(BuildContext context) {
    buildContext = context;
  }
  MediaQueryData get dimensions => MediaQuery.of(buildContext);
  ThemeData get theme => Theme.of(buildContext);
  Size get size => dimensions.size;
  double get height => size.height;
  double get width => size.width;
  double get radius => sqrt(pow(height, 2) + pow(width, 2));
}
