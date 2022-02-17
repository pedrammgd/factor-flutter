import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'factor_unofficial_specification_dialog.dart';

class FactorUnofficialSpecificationSelectItem extends StatelessWidget {
  const FactorUnofficialSpecificationSelectItem(
      {Key? key,
      required this.title,
      required this.bracesWord,
      this.onTap,
      this.itemList,
      this.topTextEditingController,
      this.bottomTextEditingController,
      this.topTextFormFieldLabel,
      this.bottomTextFormFieldLabel,
      this.titleEdit,
      this.inputFormatters,
      this.textInputType,
      this.icon = const Icon(Icons.person_add_alt),
      this.hasBottomItem = false,
      this.isSelectedName = false,
      this.hasCustomBeforeTitle = false,
      this.customBeforeTitle = '',
      this.selectedText = ''})
      : super(key: key);
  final String title;
  final String bracesWord;
  final Widget icon;
  final bool hasBottomItem;
  final Function()? onTap;
  final bool isSelectedName;
  final bool hasCustomBeforeTitle;
  final String customBeforeTitle;

  final String selectedText;
  final RxList<SpecificationCostViewModel>? itemList;
  final TextEditingController? topTextEditingController;
  final TextEditingController? bottomTextEditingController;
  final String? topTextFormFieldLabel;
  final String? bottomTextFormFieldLabel;
  final String? titleEdit;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Constants.xLargeHorizontalSpacer,
                Expanded(
                    child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'IRANSans'),
                    children: <TextSpan>[
                      TextSpan(
                          text: '($bracesWord)',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              fontFamily: 'IRANSans')),
                    ],
                  ),
                )),
                Constants.xLargeHorizontalSpacer,
                if (isSelectedName)
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        selectedText,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))
                else
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      icon,
                      Constants.smallHorizontalSpacer,
                      const Text('افزودن')
                    ],
                  )),
                Constants.largeHorizontalSpacer,
              ],
            ),
          ),
        ),
// Constants.largeVerticalSpacer,
        if (hasBottomItem)
          ListView.builder(
            itemCount: itemList?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          topTextEditingController?.text =
                              itemList![index].title;
                          bottomTextEditingController?.text =
                              itemList![index].price;
                          Get.dialog(
                            FactorUnofficialSpecificationDialog(
                              topTextFormFieldLabel: topTextFormFieldLabel!,
                              bottomTextFormFieldLabel:
                                  bottomTextFormFieldLabel!,
                              title: titleEdit!,
                              inputFormatters: inputFormatters,
                              textInputType: textInputType,
                              titleButton: 'ویرایش',
                              topTextEditingController:
                                  topTextEditingController,
                              bottomTextEditingController:
                                  bottomTextEditingController,
                              buttonOnTap: () {
                                itemList![index] = SpecificationCostViewModel(
                                    id: itemList![index].id,
                                    title: topTextEditingController!.text,
                                    price: bottomTextEditingController!.text);
                                Get.back();
                                topTextEditingController?.clear();
                                bottomTextEditingController?.clear();
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 32, bottom: 8, top: 8),
                          child: hasCustomBeforeTitle
                              ? Text(
                                  '${index + 1}- $customBeforeTitle ${itemList![index].title} : ${itemList![index].price} ریال ')
                              : Text(
                                  '${index + 1}- ${itemList![index].title} : ${itemList![index].price} ریال '),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        itemList?.removeAt(index);
                        itemList?.refresh();
                      },
                      child: const Padding(
                        padding: EdgeInsetsDirectional.only(
                            end: 20, start: 20, bottom: 8, top: 8),
                        child: Icon(Icons.remove_circle_outline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const CustomFactorDivider(
          height: 0,
          thickness: 1,
        ),
        Constants.largeVerticalSpacer,
      ],
    );
  }
}
