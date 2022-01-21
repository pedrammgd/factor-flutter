import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'factor_border_button.dart';

abstract class ExitPopUp {
  static Future<bool> showExitPopup({
    String title = 'عنوان',
    String description = 'بدنه پیام',
    String okButtonTitle = 'بله',
    String noButtonTitle = 'خیر',
    Function()? onPressedOk,
    Function()? onPressedNo,
  }) async {
    return await Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(title),
            content: Text(description),
            actions: [
              CustomBorderButton(
                onPressed: () => Get.back(result: false),
                isFilled: true,
                titleButton: noButtonTitle,
              ),
              CustomBorderButton(
                onPressed: onPressedOk,
                titleButton: okButtonTitle,
              ),
            ],
          ),
        ) ??
        false;
  }
}
