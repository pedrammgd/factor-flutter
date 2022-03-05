import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'factor_border_button.dart';

abstract class ExitPopUp {
  static Future<bool> showExitPopup({
    String title = 'عنوان',
    String description = 'بدنه پیام',
    String okButtonTitle = 'بله',
    String noButtonTitle = 'خیر',
  }) async {
    return await showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(Get.context!).colorScheme.secondary,
                        width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(title),
                  content: Text(description),
                  actions: [
                    CustomBorderButton(
                      onPressed: () => Get.back(result: false),
                      titleButton: noButtonTitle,
                      textColor: Theme.of(Get.context!).colorScheme.secondary,
                      borderColor: Theme.of(Get.context!).colorScheme.secondary,
                    ),
                    CustomBorderButton(
                      borderColor: Theme.of(Get.context!).colorScheme.secondary,
                      textColor: Theme.of(Get.context!).colorScheme.secondary,
                      onPressed: () => Get.back(result: true),
                      titleButton: okButtonTitle,
                    ),
                  ],
                )) ??
        false;
  }
}
