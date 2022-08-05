import 'package:factor_flutter_mobile/controllers/factor_header/factor_header_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/views/shared/factor_circular_progress_indicator.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_text_form_field.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class FactorHeaderPage extends GetView<FactorHeaderController> {
  const FactorHeaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorHeaderController());
    return Scaffold(
      appBar: FactorAppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'سربرگ فاکتور',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
      body: Obx(() {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            children: [
              CustomTextFormField(
                prefixIcon: const Icon(
                  Icons.title,
                ),
                textEditingController:
                    controller.factorTitleTextEditingController,
                labelText: 'عنوان فاکتور',
                validatorTextField: emptyValidator('عنوان فاکتور'),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
              ),
              Constants.smallVerticalSpacer,
              CustomTextFormField(
                prefixIcon: const Icon(Icons.format_list_numbered_rtl_sharp),
                textEditingController:
                    controller.factorNumTextEditingController,
                labelText: 'شماره فاکتور',
                suffixText: '#',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                textInputType: TextInputType.phone,
                validatorTextField: emptyValidator('شماره فاکتور'),
              ),
              _datePicker(context),
              Constants.largeVerticalSpacer,
              InkWell(
                onTap: () {
                  controller.beForeFactorDurationTextEditingController.clear();
                  controller.isBeforeFactor.value =
                      !controller.isBeforeFactor.value;
                  if (controller.isBeforeFactor.value == true) {
                    Future.delayed(
                      const Duration(milliseconds: 200),
                      () {
                        controller.focusNode.requestFocus();
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Theme.of(context).primaryColor,
                      activeColor: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: controller.isBeforeFactor.value,
                      onChanged: (value) {
                        controller.beForeFactorDurationTextEditingController
                            .clear();
                        controller.isBeforeFactor.value = value!;
                        if (value == true) {
                          Future.delayed(
                            const Duration(milliseconds: 200),
                            () {
                              controller.focusNode.requestFocus();
                            },
                          );
                        }
                      },
                    ),
                    const Text(
                      'پیش فاکتور',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Constants.mediumHorizontalSpacer,
                  Text(
                    'مدت اعتبار پیش فاکتور',
                    style: TextStyle(
                        fontWeight: controller.isBeforeFactor.value
                            ? FontWeight.bold
                            : FontWeight.w400,
                        fontSize: 14),
                  ),
                  Constants.mediumHorizontalSpacer,
                  Expanded(
                    child: FactorTextFormField(
                      focusNode: controller.focusNode,
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      controller:
                          controller.beForeFactorDurationTextEditingController,
                      contentPadding: 12,
                      hasBorder: true,
                      enabled: controller.isBeforeFactor.value ? true : false,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      textInputType: TextInputType.phone,
                      suffixText: 'روز',
                      labelText: 'مدت اعتبار',
                      validatorTextField: controller.isBeforeFactor.value
                          ? emptyValidator('مدت اعتبار')
                          : (valid) {
                              return null;
                            },
                    ),
                  ),
                ],
              ),
              Constants.xxLargeVerticalSpacer,
              FactorButton.elevated(
                titleButton: 'ثبت',
                onPressed: () {
                  controller.save();
                },
              ),
              Constants.xxLargeVerticalSpacer,
            ],
          ),
        );
      }),
    );
  }

  Widget _datePicker(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        var picked = await showPersianDatePicker(
          context: context,
          initialDate: Jalali.now(),
          firstDate: Jalali(1385, 8),
          lastDate: Jalali(1450, 9),
        );
        controller.dateSelected.value =
            picked?.formatCompactDate() ?? controller.dateSelected.value;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'تاریخ فاکتور',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.dateSelected.value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: greenColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
