import 'package:factor_flutter_mobile/controllers/factor_unofficial/add_or_edit_factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/core/utils/formatter/thousend_formatter.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/store/add_or_edit_store_controller.dart';
import '../../../models/store/hive/store_item_view_model_hive.dart';

class StoreAddModalBottomSheet
    extends GetView<AddOrEditStoreController> {
  const StoreAddModalBottomSheet( {Key? key,
    required this.boxStore,
    required this.storeItemViewModelHiveItem,
    required this.sharedPreferences,
    required this.currencyTitle,
    this.index,
  }) : super(key: key);

  final Rxn<Box> boxStore ;
  final int? index;
  final StoreItemViewModelHive? storeItemViewModelHiveItem;
  final SharedPreferences sharedPreferences;
  final String currencyTitle;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddOrEditStoreController(storeItemViewModelHiveItem,
        boxStore, sharedPreferences, currencyTitle));
    return SingleChildScrollView(
      child: Form(
        // key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
              _button(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: FactorButton.elevated(
                onPressed: () {
                  controller.save(index: index);
                },
                titleButton: 'ثبت')));
  }





  Widget _countTextFormField(BuildContext context) {
    return FactorTextFormField(
      prefixIcon: const Icon(Icons.bar_chart_outlined),
      width: double.infinity,
      controller: controller.productCountController,
      labelText: 'واحد *',
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
        LengthLimitingTextInputFormatter(12),
      ],
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.phone,
      validatorTextField: emptyValidator('واحد'),
      suffixIcon: SizedBox(width: 105, child: _unitSuffixIcon()),
      hasBorder: true,
    );
  }

  Widget _unitSuffixIcon() => Obx(() {
        return PopupMenuButton<String>(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                controller.unitValue.value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Constants.veryTinyHorizontalSpacer,
              Flexible(
                child: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                ),
              ),
            ],
          ),
          iconSize: 20,
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          onSelected: (value) async {
            controller.unitValue.value = value;
            if (value == 'افزودن واحد دلخواه +') {
              controller.addUnitPriceController.clear();
              controller.unitValue.value = 'عدد';
              final result = await Get.dialog(_unitAlertDialog());
              if (result != null) {
                controller.unitValue.value = result;
              }
            }
          },
          itemBuilder: (context) => controller.unitList
              .map((e) => PopupMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
        );
      });

  Widget _unitAlertDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.only(top: 5, bottom: 20),
      content: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
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
              const Text(
                'افزودن واحد',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Constants.mediumVerticalSpacer,
              FactorTextFormField(
                controller: controller.addUnitPriceController,
                hasBorder: true,
                labelText: 'واحد جدید',
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12),
                ],
                textInputAction: TextInputAction.done,
                prefixIcon: const Icon(Icons.title),
                validatorTextField: emptyValidator('واحد جدید'),
              ),
              Constants.mediumVerticalSpacer,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FactorButton(
                      onPressed: () {
                        if (!controller.formKey.currentState!.validate()) {
                          return;
                        }
                        controller.unitList
                            .add(controller.addUnitPriceController.text);
                        Get.back(
                            result: controller.addUnitPriceController.text);
                      },
                      titleButton: 'افزودن',
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _unitPriceTextFormFeild(BuildContext context) {
    return FactorTextFormField(
      width: double.infinity,
      prefixIcon: const Icon(Icons.attach_money),
      controller: controller.productUnitPriceController,
      labelText: 'قیمت واحد *',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
        LengthLimitingTextInputFormatter(12),
        ThousandsSeparatorInputFormatter(),
      ],
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.phone,
      validatorTextField: emptyValidator('قیمت واحد'),
      suffixText: controller.currencyTitle,
      hasBorder: true,
    );
  }

  Widget _descriptionTextFormField(BuildContext context) {
    return FactorTextFormField(
      controller: controller.productDescriptionController,
      width: double.infinity,
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.description_outlined),
      labelText: 'شرح کالا *',
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
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
