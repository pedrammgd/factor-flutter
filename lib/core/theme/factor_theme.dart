import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class FactorTheme {
  static final darkTheme = ThemeData(
    fontFamily: 'IRANSans',
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(secondary: Colors.white),
  );
  static final lightTheme = ThemeData(
    fontFamily: 'IRANSans',
    scaffoldBackgroundColor: backGroundScaffoldColor,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(secondary: Colors.black),
  );
}
