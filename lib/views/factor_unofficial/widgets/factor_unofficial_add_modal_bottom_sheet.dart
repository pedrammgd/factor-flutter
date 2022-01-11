import 'package:factor_flutter_mobile/controllers/factor_unofficial/add_or_edit_factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
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
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: FactorTextFormField(
                controller: controller.productCountController,
                labelText: 'تعداد *',
              )),
              Expanded(
                  child: FactorTextFormField(
                controller: controller.productUnitPriceController,
                labelText: 'قیمت واحد *',
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: FactorTextFormField(
                controller: controller.productDiscountController,
                labelText: 'تخفیف',
              )),
              Expanded(
                  child: FactorTextFormField(
                controller: controller.productTaxationController,
                labelText: 'مالیات',
              )),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        controller.save();
                      }, child: const Text('ثبت')))),
        ],
          ),
    );
  }
}
