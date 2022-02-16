import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FactorUnofficialSpecificationDialog extends StatelessWidget {
  const FactorUnofficialSpecificationDialog(
      {Key? key,
      this.title = 'عنوان',
      this.topTextFormFieldLabel = 'تکست فیلد اول',
      this.bottomTextFormFieldLabel = 'تکی فیلد دوم',
      this.closeOnTap,
      this.bottomTextEditingController,
      this.topTextEditingController,
      this.buttonOnTap})
      : super(key: key);

  final String title;
  final String topTextFormFieldLabel;
  final String bottomTextFormFieldLabel;
  final TextEditingController? bottomTextEditingController;
  final TextEditingController? topTextEditingController;
  final Function()? closeOnTap;
  final Function()? buttonOnTap;

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
                onTap: closeOnTap ?? () => Get.back(),
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
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Constants.mediumVerticalSpacer,
            FactorTextFormField(
              controller: topTextEditingController,
              hasBorder: true,
              labelText: topTextFormFieldLabel,
              prefixIcon: const Icon(Icons.title),
            ),
            Constants.smallVerticalSpacer,
            FactorTextFormField(
              controller: bottomTextEditingController,
              hasBorder: true,
              labelText: bottomTextFormFieldLabel,
              prefixIcon: const Icon(Icons.attach_money),
              suffixText: 'ریال',
            ),
            Constants.mediumVerticalSpacer,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomBorderButton(onPressed: buttonOnTap)),
            ),
          ],
        ),
      ),
    );
  }
}
