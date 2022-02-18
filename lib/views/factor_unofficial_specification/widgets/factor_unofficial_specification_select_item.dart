import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'factor_unofficial_specification_dialog.dart';

//ignore: must_be_immutable
class FactorUnofficialSpecificationSelectItem extends StatefulWidget {
  FactorUnofficialSpecificationSelectItem(
      {required this.title,
      required this.bracesWord,
      this.onTap,
      this.itemList = const [],
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
      this.selectedText = '',
      this.keyForm,
      this.textAddColor = Colors.black,
      required this.totalPrice,
      required this.statusBracketKeyText});

  final String title;
  final GlobalKey<FormState>? keyForm;
  final String bracesWord;
  final Widget icon;
  final bool hasBottomItem;
  final Function()? onTap;
  final bool isSelectedName;
  final bool hasCustomBeforeTitle;
  final String customBeforeTitle;

  final String selectedText;
  final List<SpecificationCostViewModel> itemList;
  final TextEditingController? topTextEditingController;
  final TextEditingController? bottomTextEditingController;
  final String? topTextFormFieldLabel;
  final String? bottomTextFormFieldLabel;
  final String? titleEdit;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Color textAddColor;
  RxDouble totalPrice;
  final RxInt statusBracketKeyText;

  @override
  State<FactorUnofficialSpecificationSelectItem> createState() =>
      _FactorUnofficialSpecificationSelectItemState();
}

class _FactorUnofficialSpecificationSelectItemState
    extends State<FactorUnofficialSpecificationSelectItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Constants.xLargeHorizontalSpacer,
                Expanded(
                    child: RichText(
                  text: TextSpan(
                    text: widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'IRANSans'),
                    children: <TextSpan>[
                      TextSpan(
                          text: '(${widget.bracesWord})',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              fontFamily: 'IRANSans')),
                    ],
                  ),
                )),
                Constants.xLargeHorizontalSpacer,
                if (widget.isSelectedName)
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.selectedText,
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
                      widget.icon,
                      Constants.smallHorizontalSpacer,
                      Text(
                        'افزودن',
                        style: TextStyle(color: widget.textAddColor),
                      )
                    ],
                  )),
                Constants.largeHorizontalSpacer,
              ],
            ),
          ),
        ),
// Constants.largeVerticalSpacer,
        if (widget.itemList.isNotEmpty)
          ListView.builder(
            itemCount: widget.itemList.length,
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
                          widget.topTextEditingController?.text =
                              widget.itemList[index].title;
                          widget.bottomTextEditingController?.text =
                              widget.itemList[index].price;
                          Get.dialog(
                            FactorUnofficialSpecificationDialog(
                              keyForm: widget.keyForm,
                              topTextFormFieldLabel:
                                  widget.topTextFormFieldLabel!,
                              bottomTextFormFieldLabel:
                                  widget.bottomTextFormFieldLabel!,
                              title: widget.titleEdit!,
                              inputFormatters: widget.inputFormatters,
                              textInputType: widget.textInputType,
                              titleButton: 'ویرایش',
                              topTextEditingController:
                                  widget.topTextEditingController,
                              bottomTextEditingController:
                                  widget.bottomTextEditingController,
                              onFieldSubmitted: (val) {
                                widget.itemList[index] =
                                    SpecificationCostViewModel(
                                        id: widget.itemList[index].id,
                                        title: widget
                                            .topTextEditingController!.text,
                                        price: widget
                                            .bottomTextEditingController!.text);
                                Get.back();
                                widget.topTextEditingController?.clear();
                                widget.bottomTextEditingController?.clear();
                              },
                              buttonOnTap: () {
                                if (!widget.keyForm!.currentState!.validate())
                                  return;

                                widget.itemList[index] =
                                    SpecificationCostViewModel(
                                        id: widget.itemList[index].id,
                                        title: widget
                                            .topTextEditingController!.text,
                                        price: widget
                                            .bottomTextEditingController!.text);
                                totalMinesPriceSpecific(widget
                                    .itemList[index].price
                                    .replaceAll(RegExp(','), ''));
                                Get.back();
                                widget.topTextEditingController?.clear();
                                widget.bottomTextEditingController?.clear();
                                setState(() {});
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 32, bottom: 8, top: 8),
                          child: widget.hasCustomBeforeTitle
                              ? Text(
                                  '${index + 1}- ${widget.customBeforeTitle} ${widget.itemList[index].title} : ${widget.itemList[index].price} ریال ',
                                  style: TextStyle(color: widget.textAddColor))
                              : Text(
                                  '${index + 1}- ${widget.itemList[index].title} : ${widget.itemList[index].price} ریال ',
                                  style: TextStyle(color: widget.textAddColor),
                                ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        totalMinesPriceSpecific(widget.itemList[index].price
                            .replaceAll(RegExp(','), ''));
                        setState(() {
                          widget.itemList.removeAt(index);
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsetsDirectional.only(
                            end: 20, start: 20, bottom: 8, top: 8),
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
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

  RxDouble totalMinesPriceSpecific(String price) {
    widget.totalPrice.value -= double.parse(price);
    if (widget.totalPrice.value < 0) {
      widget.statusBracketKeyText(1);
    } else if (widget.totalPrice.value == 0) {
      widget.statusBracketKeyText(3);
    } else {
      widget.statusBracketKeyText(0);
    }
    return widget.totalPrice;
  }
}
