import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ExitPopUp {
  static Future<bool> showExitPopup({
    String title = 'عنوان',
    String description = 'بدنه پیام',
    String okButtonTitle = 'خروج',
    String noButtonTitle = 'هستم فعلا',
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
                    FactorButton.elevated(
                      primaryColor: redColor,
                      borderColor: redColor,
                      width: 70,
                      textColor: Theme.of(Get.context!).primaryColor,
                      onPressed: () => Get.back(result: true),
                      titleButton: okButtonTitle,
                    ),
                    FactorButton.elevated(
                      width: 90,
                      onPressed: () => Get.back(result: false),
                      titleButton: noButtonTitle,
                      textColor: Theme.of(Get.context!).primaryColor,
                    ),
                  ],
                )) ??
        false;
  }
}
