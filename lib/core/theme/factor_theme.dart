import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class FactorTheme {
  static final darkTheme = ThemeData(
    fontFamily: 'IRANSans',
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(secondary: Colors.white, primary: greenColor),
  );
  static final lightTheme = ThemeData(
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: greenColor),
    fontFamily: 'IRANSans',
    scaffoldBackgroundColor: backGroundScaffoldColor,
    primaryColor: Colors.white,
    colorScheme:
        ColorScheme.light(secondary: Colors.black, primary: greenColor),
  );
}
