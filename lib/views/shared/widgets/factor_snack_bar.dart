import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorSnackBar {
  static void getxSnackBar(
      {Color backgroundColor = const Color(0xff4AA96C),
      required String title,
      required String message,
      String? icon,
      Widget? iconWidget,
      SnackPosition? snackPosition,
      TextButton? mainButton,
      Duration? duration = const Duration(seconds: 3)}) {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      mainButton: mainButton,
      duration: duration,
      icon: iconWidget ??
          Image.asset(
            icon ?? coffeeCupIcon,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            // color: Theme.of(Get.context!).colorScheme.secondary,
          ),
    );
  }
}
