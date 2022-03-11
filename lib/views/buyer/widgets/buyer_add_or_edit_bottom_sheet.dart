import 'dart:ui';

import 'package:factor_flutter_mobile/controllers/buyer/buyer_add_or_edit_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_text_form_field.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerAddOrEditBottomSheet extends GetView<BuyerAddOrEditController> {
  const BuyerAddOrEditBottomSheet({
    Key? key,
    required this.buyerList,
    required this.sharedPreferences,
    required this.buyerItem,
  }) : super(key: key);
  final RxList<BuyerViewModel> buyerList;
  final SharedPreferences sharedPreferences;
  final BuyerViewModel? buyerItem;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<BuyerAddOrEditController>(() => BuyerAddOrEditController(
        buyerItem,
        buyerList: buyerList,
        sharedPreferences: sharedPreferences));
    return SingleChildScrollView(
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _topDivider(),
                ],
              ),
              _radioButton(),
              if (controller.isHaghighi.value)
                Form(key: controller.haghighiFormKey, child: _haghighiForm())
              else
                Form(key: controller.hoghoghiFormKey, child: _hoghoghiForm()),
              _button(),
            ],
          ),
        );
      }),
    );
  }

  Widget _hoghoghiForm() {
    return Column(
      children: [
        CustomTextFormField(
          labelText: 'نام شرکت',
          textEditingController: controller.companyNameTextEditingController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          validatorTextField: emptyValidator('نام شرکت'),
        ),
        CustomTextFormField(
          labelText: 'شناسه ملی شرکت',
          textEditingController:
              controller.nationalCodeCompanyTextEditingController,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          textInputType: TextInputType.phone,
        ),
        CustomTextFormField(
          labelText: 'شماره تماس',
          textEditingController: controller.mobileTextHoghoghiEditingController,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          validatorTextField: emptyValidator('شماره تماس'),
          textInputType: TextInputType.phone,
        ),
        CustomTextFormField(
          labelText: 'آدرس',
          maxLines: 2,
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          textEditingController:
              controller.addressTextHoghohgiEditingController,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _haghighiForm() {
    return Column(
      children: [
        CustomTextFormField(
          labelText: 'نام و نام خانوادگی',
          textEditingController: controller.fullNameTextEditingController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          validatorTextField: emptyValidator('نام و نام خانوادگی'),
        ),
        CustomTextFormField(
          labelText: 'کد ملی',
          textEditingController: controller.nationalCodeTextEditingController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.digitsOnly,
          ],
          textInputType: TextInputType.phone,
        ),
        CustomTextFormField(
          labelText: 'شماره تماس',
          textEditingController: controller.mobileTextEditingController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.digitsOnly,
          ],
          textInputType: TextInputType.phone,
          validatorTextField: emptyValidator('شماره تماس'),
        ),
        CustomTextFormField(
          labelText: 'آدرس',
          maxLines: 2,
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          textEditingController: controller.addressTextEditingController,
          textInputAction: TextInputAction.done,
        )
      ],
    );
  }

  Widget _radioButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15),
      child: Row(
        children: [
          const Text(
            'نوع مشتری :',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Constants.largeHorizontalSpacer,
          SizedBox(
            width: 10,
            child: Radio<bool>(
              activeColor: Theme.of(Get.context!).colorScheme.secondary,
              value: true,
              groupValue: controller.isHaghighi.value,
              onChanged: (value) {
                controller.isHaghighi.value = value!;
                print(controller.isHaghighi.value);
              },
            ),
          ),
          TextButton(
            onPressed: () => controller.isHaghighi.value = true,
            child: Text(
              'حقیقی',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).colorScheme.secondary),
            ),
          ),
          Constants.smallHorizontalSpacer,
          SizedBox(
            width: 10,
            child: Radio<bool>(
              activeColor: Theme.of(Get.context!).colorScheme.secondary,
              value: false,
              groupValue: controller.isHaghighi.value,
              onChanged: (value) {
                controller.isHaghighi.value = value!;
                print(controller.isHaghighi.value);
              },
            ),
          ),
          TextButton(
            onPressed: () => controller.isHaghighi.value = false,
            child: Text(
              'حقوقی',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: CustomBorderButton(
                borderColor: Theme.of(Get.context!).colorScheme.secondary,
                textColor: Theme.of(Get.context!).colorScheme.secondary,
                onPressed: () {
                  controller.save();
                },
                titleButton: controller.isEdit ? 'ویرایش' : 'ثبت')));
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
