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
    required BuildContext context,
  }) async {
    return await Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(title),
            content: Text(description),
            actions: [
              CustomBorderButton(
                onPressed: () => Get.back(result: false),
                titleButton: noButtonTitle,
                textColor: Theme.of(context).colorScheme.secondary,
                borderColor: Theme.of(context).colorScheme.secondary,
              ),
              CustomBorderButton(
                borderColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.secondary,
                onPressed: onPressedOk,
                titleButton: okButtonTitle,
              ),
            ],
          ),
        ) ??
        false;
  }
}
