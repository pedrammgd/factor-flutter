import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDeleteDialog extends StatelessWidget {
  const AlertDeleteDialog(
      {Key? key,
      required this.onPressed,
      required this.index,
      required this.title})
      : super(key: key);

  final Function()? onPressed;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.only(top: 5, bottom: 20),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 5, start: 15),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            Constants.mediumVerticalSpacer,
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text.rich(
                  TextSpan(text: 'آیا می خواهید ', children: [
                    TextSpan(
                        text: title, style: const TextStyle(color: Colors.red)),
                    const TextSpan(text: ' را حذف کنید')
                  ]),
                  // ''''  آیا می خواهید $title'  را حذف کنید     ''',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Constants.largeVerticalSpacer,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: FactorButton(
                    borderColor: Colors.red,
                    textColor: Colors.red,
                    onPressed: onPressed,
                    titleButton: 'حذف',
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
