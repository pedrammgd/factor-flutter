import 'package:factor_flutter_mobile/controllers/factor_unofficial_specification/factor_unofficial_specification_add_or_edit_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/core/utils/formatter/thousend_formatter.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FactorUnofficialSpecificationAddOrEditDialog
    extends GetView<FactorUnofficialSpecificationAddOrEditController> {
  final RxList<SpecificationCostViewModel> specificationCostList;
  final SpecificationCostViewModel? specificationCostItem;
  final String titleDialog;
  final String topTextFormFieldLabel;
  final String bottomTextFormFieldLabel;
  final List<TextInputFormatter>? inputFormatters;
  final String currencyTitle;

  final TextInputType? textInputType;
  const FactorUnofficialSpecificationAddOrEditDialog({
    this.inputFormatters,
    this.textInputType,
    this.topTextFormFieldLabel = 'عنوان هزینه',
    this.bottomTextFormFieldLabel = 'قیمت',
    required this.specificationCostList,
    this.specificationCostItem,
    required this.titleDialog,
    required this.currencyTitle,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<FactorUnofficialSpecificationAddOrEditController>(
        () => FactorUnofficialSpecificationAddOrEditController(
              specificationCostList: specificationCostList,
              item: specificationCostItem,
            ));

    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.only(top: 5, bottom: 20),
      content: SingleChildScrollView(
        child: Form(
          key: controller.keyForm,
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
              Text(
                controller.isEdit
                    ? 'ویرایش $titleDialog'
                    : 'افزودن $titleDialog',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Constants.mediumVerticalSpacer,
              FactorTextFormField(
                controller: controller.titleTextEditingController,
                hasBorder: true,
                inputFormatters: inputFormatters,
                textInputType: textInputType,
                labelText: topTextFormFieldLabel,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.title),
                validatorTextField: emptyValidator(topTextFormFieldLabel),
              ),
              Constants.smallVerticalSpacer,
              FactorTextFormField(
                onFieldSubmitted: (value) => controller.save(),
                controller: controller.costPriceTextEditingController,
                hasBorder: true,
                prefixIcon: const Icon(Icons.attach_money),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                  LengthLimitingTextInputFormatter(15),
                  ThousandsSeparatorInputFormatter(),
                ],
                labelText: bottomTextFormFieldLabel,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                suffixText: currencyTitle,
                validatorTextField: emptyValidator(bottomTextFormFieldLabel),
              ),
              Constants.mediumVerticalSpacer,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: CustomBorderButton(
                      onPressed: () {
                        controller.save();
                      },
                      titleButton: controller.isEdit ? 'ویرایش' : 'افزودن',
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
