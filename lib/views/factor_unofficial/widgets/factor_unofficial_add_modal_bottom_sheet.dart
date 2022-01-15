import 'package:factor_flutter_mobile/controllers/factor_unofficial/add_or_edit_factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FactorUnofficialAddModalBottomSheet
    extends GetView<AddOrEditFactorUnofficialController> {
   FactorUnofficialAddModalBottomSheet(
      {required this.factorUnofficialItemList,
       required this.factorUnofficialItem,required this.sharedPreferences});


  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  final   FactorUnofficialItemViewModel? factorUnofficialItem;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddOrEditFactorUnofficialController(
        factorUnofficialItem, factorUnofficialItemList,sharedPreferences));
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.all(10),
                  height: 3,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
            FactorTextFormField(
              controller: controller.productDescriptionController,
              width: double.infinity,
              labelText: 'شرح کالا *',
              borderColor: Colors.black,
              hasBorder: true,
              validatorTextField: emptyValidator('شرح کالا'),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: FactorTextFormField(
                      controller: controller.productCountController,
                  labelText: 'تعداد *',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                  validatorTextField: emptyValidator('تعداد'),
                  suffixText: 'عدد',
                  hasBorder: true,
                )),
                Expanded(
                    child: FactorTextFormField(
                      controller: controller.productUnitPriceController,
                  labelText: 'قیمت واحد *',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                  validatorTextField: emptyValidator('قیمت واحد'),
                  suffixText: '^ ریال',
                  hasBorder: true,
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: FactorTextFormField(
                      controller: controller.productDiscountController,
                  labelText: 'تخفیف',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                  suffixText: '%',
                  hasBorder: true,
                )),
                Expanded(
                    child: FactorTextFormField(
                      controller: controller.productTaxationController,
                  labelText: 'مالیات',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                  suffixText: '%',
                  hasBorder: true,
                )),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          controller.save();
                        },
                        child: const Text('ثبت')))),
          ],
        ),
      ),
    );
  }
}
