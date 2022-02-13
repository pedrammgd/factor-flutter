import 'dart:ui';

import 'package:factor_flutter_mobile/controllers/buyer/buyer_add_or_edit_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_text_form_field.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:flutter/material.dart';
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
        return Form(
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
              _radioButton(),
              if (controller.isHaghighi.value)
                Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      labelText: 'نام',
                      paddingHorizontal: 4,
                      textEditingController:
                          controller.firstNameTextEditingController,
                    )),
                    Expanded(
                        child: CustomTextFormField(
                      labelText: 'نام خانوادگی',
                      paddingHorizontal: 4,
                      textEditingController:
                          controller.lastNameTextEditingController,
                    )),
                  ],
                )
              else
                CustomTextFormField(
                  labelText: 'نام شرکت',
                  paddingHorizontal: 8,
                  textEditingController:
                      controller.companyNameTextEditingController,
                ),
              if (controller.isHaghighi.value)
                CustomTextFormField(
                  labelText: 'کد ملی',
                  paddingHorizontal: 8,
                  textEditingController:
                      controller.nationalCodeTextEditingController,
                )
              else
                CustomTextFormField(
                  labelText: 'شناسه ملی شرکت',
                  paddingHorizontal: 8,
                  textEditingController:
                      controller.nationalCodeCompanyTextEditingController,
                ),
              if (!controller.isHaghighi.value)
                CustomTextFormField(
                  labelText: 'شماره ثبت',
                  paddingHorizontal: 8,
                  textEditingController:
                      controller.registrationIDTextEditingController,
                ),
              if (controller.isHaghighi.value)
                CustomTextFormField(
                  labelText: 'شماره تماس',
                  paddingHorizontal: 8,
                  textEditingController: controller.mobileTextEditingController,
                )
              else
                CustomTextFormField(
                  labelText: 'شماره تماس',
                  paddingHorizontal: 8,
                  textEditingController:
                      controller.mobileTextHoghoghiEditingController,
                ),
              CustomTextFormField(
                labelText: 'آدرس',
                paddingHorizontal: 8,
                maxLines: 2,
                textEditingController: controller.isHaghighi.value
                    ? controller.addressTextEditingController
                    : controller.addressTextHoghohgiEditingController,
              ),
              _button(),
            ],
          ),
        );
      }),
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
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: CustomBorderButton(
                borderColor: Theme.of(Get.context!).colorScheme.secondary,
                textColor: Theme.of(Get.context!).colorScheme.secondary,
                onPressed: () {
                  controller.save();
                },
                titleButton: 'ثبت')));
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
