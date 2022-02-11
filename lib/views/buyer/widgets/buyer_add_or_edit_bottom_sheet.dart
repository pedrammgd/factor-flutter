import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyerAddOrEditBottomSheet extends StatelessWidget {
  const BuyerAddOrEditBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        // key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _topDivider(),
              ],
            ),
            Row(
              children: [
                Expanded(child: _buyerTextFormField(labelText: 'labelText')),
                Expanded(child: _buyerTextFormField(labelText: 'labelText')),
              ],
            ),
            _buyerTextFormField(labelText: 'labelText'),
            _buyerTextFormField(labelText: 'labelText'),
            _buyerTextFormField(labelText: 'labelText'),
            _button(),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: CustomBorderButton(
                borderColor: Theme.of(Get.context!).colorScheme.secondary,
                textColor: Theme.of(Get.context!).colorScheme.secondary,
                onPressed: () {
                  // controller.save();
                },
                titleButton: 'ثبت')));
  }

  Widget _buyerTextFormField({required String labelText}) {
    return FactorTextFormField(
      // controller: controller.productDescriptionController,
      suffixColor: Theme.of(Get.context!).colorScheme.secondary,
      labelColor: Theme.of(Get.context!).colorScheme.secondary,
      width: double.infinity,
      labelText: labelText,
      borderColor: Theme.of(Get.context!).colorScheme.secondary,
      hasBorder: true,
      validatorTextField: emptyValidator('شرح کالا'),
    );
  }

  Widget _topDivider() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: const EdgeInsetsDirectional.all(10),
        height: 3,
        width: 50,
        decoration: BoxDecoration(
            color: Theme.of(Get.context!).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
