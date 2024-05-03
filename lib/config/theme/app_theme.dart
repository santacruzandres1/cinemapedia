import 'package:flutter/material.dart';


class AppTheme{

  List <Color> colors = [
    Colors.blue,
    Colors.red,
    ];

  ThemeData getTheme()=>ThemeData(
    colorSchemeSeed: colors[0]
  );
}