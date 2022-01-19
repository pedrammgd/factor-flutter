import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ExitPopUp {
  static Future<bool> showExitPopup({
    String title = 'عنوان',
    String description = 'بدنه پیام',
    String okButtonTitle = 'بله',
    String noButtonTitle = 'خیر',
  }) async {
    return await Get.dialog(
          AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(result: false),
                child: Text(noButtonTitle),
              ),
              ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: Text(okButtonTitle),
              ),
            ],
          ),
        ) ??
        false;
  }
}
