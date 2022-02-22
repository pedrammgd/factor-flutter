import 'package:factor_flutter_mobile/controllers/factor_unofficial/add_or_edit_factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/core/utils/formatter/thousend_formatter.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorUnofficialAddModalBottomSheet
    extends GetView<AddOrEditFactorUnofficialController> {
  FactorUnofficialAddModalBottomSheet({
    required this.factorUnofficialItemList,
    required this.factorUnofficialItem,
    required this.sharedPreferences,
  });

  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  final FactorUnofficialItemViewModel? factorUnofficialItem;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddOrEditFactorUnofficialController(
        factorUnofficialItem, factorUnofficialItemList, sharedPreferences));
    return SingleChildScrollView(
      child: Form(
        // key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _topDivider(context),
              ],
            ),
            _descriptionTextFormField(context),
            _unitPriceTextFormFeild(context),
            _countTextFormField(context),
            Row(
              children: [
                _discountTextFormField(context),
                _taxationTextFormFild(context),
              ],
            ),
            _button(context),
          ],
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: CustomBorderButton(
                borderColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  controller.save();
                },
                titleButton: 'ثبت')));
  }

  Widget _taxationTextFormFild(BuildContext context) {
    return Expanded(
        child: FactorTextFormField(
      labelColor: Theme.of(context).colorScheme.secondary,
      borderColor: Theme.of(context).colorScheme.secondary,
      suffixColor: Theme.of(context).colorScheme.secondary,
      controller: controller.productTaxationController,
      labelText: 'مالیات',
      validatorTextField: percentValidator('مالیات'),
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
      ],
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.phone,
      suffixText: '%',
      hasBorder: true,
    ));
  }

  Widget _discountTextFormField(BuildContext context) {
    return Expanded(
        child: FactorTextFormField(
      controller: controller.productDiscountController,
      labelColor: Theme.of(context).colorScheme.secondary,
      borderColor: Theme.of(context).colorScheme.secondary,
      suffixColor: Theme.of(context).colorScheme.secondary,
      labelText: 'تخفیف',
      validatorTextField: percentValidator('تخفیف'),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
        LengthLimitingTextInputFormatter(4),
      ],
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.phone,
      suffixText: '%',
      hasBorder: true,
    ));
  }

  Widget _countTextFormField(BuildContext context) {
    return FactorTextFormField(
      width: double.infinity,
      controller: controller.productCountController,
      labelColor: Theme.of(context).colorScheme.secondary,
      suffixColor: Theme.of(context).colorScheme.secondary,
      borderColor: Theme.of(context).colorScheme.secondary,
      labelText: 'تعداد *',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.phone,
      validatorTextField: emptyValidator('تعداد'),
      suffixText: 'عدد',
      hasBorder: true,
    );
  }

  Widget _unitPriceTextFormFeild(BuildContext context) {
    return FactorTextFormField(
      width: double.infinity,
      controller: controller.productUnitPriceController,
      labelColor: Theme.of(context).colorScheme.secondary,
      borderColor: Theme.of(context).colorScheme.secondary,
      suffixColor: Theme.of(context).colorScheme.secondary,
      labelText: 'قیمت واحد *',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
        ThousandsSeparatorInputFormatter(),
      ],
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.phone,
      validatorTextField: emptyValidator('قیمت واحد'),
      suffixText: 'ریال',
      hasBorder: true,
    );
  }

  Widget _descriptionTextFormField(BuildContext context) {
    return FactorTextFormField(
      controller: controller.productDescriptionController,
      suffixColor: Theme.of(context).colorScheme.secondary,
      labelColor: Theme.of(context).colorScheme.secondary,
      width: double.infinity,
      labelText: 'شرح کالا *',
      borderColor: Theme.of(context).colorScheme.secondary,
      hasBorder: true,
      validatorTextField: emptyValidator('شرح کالا'),
    );
  }

  Widget _topDivider(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: const EdgeInsetsDirectional.all(10),
        height: 3,
        width: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
