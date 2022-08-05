// import 'package:factor_flutter_mobile/core/constans/constans.dart';
// import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
// import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import 'factor_unofficial_specification_dialog.dart';
//
// //ignore: must_be_immutable
// class FactorUnofficialSpecificationSelectItem extends StatefulWidget {
//   FactorUnofficialSpecificationSelectItem(
//       {required this.title,
//       required this.bracesWord,
//       this.onTap,
//       this.itemList = const [],
//       this.topTextEditingController,
//       this.bottomTextEditingController,
//       this.topTextFormFieldLabel,
//       this.bottomTextFormFieldLabel,
//       this.titleEdit,
//       this.inputFormatters,
//       this.textInputType,
//       this.icon = const Icon(Icons.person_add_alt),
//       this.hasBottomItem = false,
//       this.isSelectedName = false,
//       this.hasCustomBeforeTitle = false,
//       this.customBeforeTitle = '',
//       this.selectedText = '',
//       this.keyForm,
//       this.textAddColor = Colors.black,
//       required this.totalPrice,
//       required this.statusBracketKeyText});
//
//   final String title;
//   final GlobalKey<FormState>? keyForm;
//   final String bracesWord;
//   final Widget icon;
//   final bool hasBottomItem;
//   final Function()? onTap;
//   final bool isSelectedName;
//   final bool hasCustomBeforeTitle;
//   final String customBeforeTitle;
//
//   final String selectedText;
//   final List<SpecificationCostViewModel> itemList;
//   final TextEditingController? topTextEditingController;
//   final TextEditingController? bottomTextEditingController;
//   final String? topTextFormFieldLabel;
//   final String? bottomTextFormFieldLabel;
//   final String? titleEdit;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? textInputType;
//   final Color textAddColor;
//   RxDouble totalPrice;
//   final RxInt statusBracketKeyText;
//
//   @override
//   State<FactorUnofficialSpecificationSelectItem> createState() =>
//       _FactorUnofficialSpecificationSelectItemState();
// }
//
// class _FactorUnofficialSpecificationSelectItemState
//     extends State<FactorUnofficialSpecificationSelectItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InkWell(
//           onTap: widget.onTap,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 12, top: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Constants.xLargeHorizontalSpacer,
//                 Expanded(
//                     child: RichText(
//                   text: TextSpan(
//                     text: widget.title,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 13,
//                         fontFamily: 'IRANSans'),
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: '(${widget.bracesWord})',
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 11,
//                               fontFamily: 'IRANSans')),
//                     ],
//                   ),
//                 )),
//                 Constants.xLargeHorizontalSpacer,
//                 if (widget.isSelectedName)
//                   Expanded(
//                       child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         widget.selectedText,
//                         style: const TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ))
//                 else
//                   Expanded(
//                       child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       widget.icon,
//                       Constants.smallHorizontalSpacer,
//                       Text(
//                         'افزودن',
//                         style: TextStyle(color: widget.textAddColor),
//                       )
//                     ],
//                   )),
//                 Constants.largeHorizontalSpacer,
//               ],
//             ),
//           ),
//         ),
// // Constants.largeVerticalSpacer,
//         if (widget.itemList.isNotEmpty)
//           ListView.builder(
//             itemCount: widget.itemList.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) => Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(10),
//                         onTap: () {
//                           widget.topTextEditingController?.text =
//                               widget.itemList[index].title;
//                           widget.bottomTextEditingController?.text =
//                               widget.itemList[index].price;
//                           Get.dialog(
//                             FactorUnofficialSpecificationDialog(
//                               keyForm: widget.keyForm,
//                               topTextFormFieldLabel:
//                                   widget.topTextFormFieldLabel!,
//                               bottomTextFormFieldLabel:
//                                   widget.bottomTextFormFieldLabel!,
//                               title: widget.titleEdit!,
//                               inputFormatters: widget.inputFormatters,
//                               textInputType: widget.textInputType,
//                               titleButton: 'ویرایش',
//                               topTextEditingController:
//                                   widget.topTextEditingController,
//                               bottomTextEditingController:
//                                   widget.bottomTextEditingController,
//                               onFieldSubmitted: (val) {
//                                 widget.itemList[index] =
//                                     SpecificationCostViewModel(
//                                         id: widget.itemList[index].id,
//                                         title: widget
//                                             .topTextEditingController!.text,
//                                         price: widget
//                                             .bottomTextEditingController!.text);
//                                 Get.back();
//                                 widget.topTextEditingController?.clear();
//                                 widget.bottomTextEditingController?.clear();
//                               },
//                               buttonOnTap: () {
//                                 if (!widget.keyForm!.currentState!.validate())
//                                   return;
//
//                                 widget.itemList[index] =
//                                     SpecificationCostViewModel(
//                                         id: widget.itemList[index].id,
//                                         title: widget
//                                             .topTextEditingController!.text,
//                                         price: widget
//                                             .bottomTextEditingController!.text);
//                                 totalMinesPriceSpecific(widget
//                                     .itemList[index].price
//                                     .replaceAll(RegExp(','), ''));
//                                 Get.back();
//                                 widget.topTextEditingController?.clear();
//                                 widget.bottomTextEditingController?.clear();
//                                 setState(() {});
//                               },
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.only(
//                               start: 32, bottom: 8, top: 8),
//                           child: widget.hasCustomBeforeTitle
//                               ? Text(
//                                   '${index + 1}- ${widget.customBeforeTitle} ${widget.itemList[index].title} : ${widget.itemList[index].price} ریال ',
//                                   style: TextStyle(color: widget.textAddColor))
//                               : Text(
//                                   '${index + 1}- ${widget.itemList[index].title} : ${widget.itemList[index].price} ریال ',
//                                   style: TextStyle(color: widget.textAddColor),
//                                 ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       borderRadius: BorderRadius.circular(10),
//                       onTap: () {
//                         totalMinesPriceSpecific(widget.itemList[index].price
//                             .replaceAll(RegExp(','), ''));
//                         setState(() {
//                           widget.itemList.removeAt(index);
//                         });
//                       },
//                       child: const Padding(
//                         padding: EdgeInsetsDirectional.only(
//                             end: 20, start: 20, bottom: 8, top: 8),
//                         child: Icon(
//                           Icons.remove_circle_outline,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         const CustomFactorDivider(
//           height: 0,
//           thickness: 1,
//         ),
//         Constants.largeVerticalSpacer,
//       ],
//     );
//   }
//
//   RxDouble totalMinesPriceSpecific(String price) {
//     widget.totalPrice.value -= double.parse(price);
//     if (widget.totalPrice.value < 0) {
//       widget.statusBracketKeyText(1);
//     } else if (widget.totalPrice.value == 0) {
//       widget.statusBracketKeyText(3);
//     } else {
//       widget.statusBracketKeyText(0);
//     }
//     return widget.totalPrice;
//   }
// }
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/alert_delete_dialog.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'factor_unofficial_specification_add_or_edit_dialog.dart';

class FactorUnofficialSpecificationSelectItem extends StatefulWidget {
  FactorUnofficialSpecificationSelectItem({
    required this.title,
    required this.bracesWord,
    this.onTap,
    required this.itemList,
    this.topTextEditingController,
    this.bottomTextEditingController,
    this.topTextFormFieldLabel = 'عنوان هزینه',
    this.bottomTextFormFieldLabel = 'قیمت',
    this.titleEdit,
    this.inputFormatters,
    this.textInputType,
    this.icon = const Icon(Icons.person_add_alt),
    this.hasBottomItem = false,
    this.isSelectedName = false,
    this.hasCustomBeforeTitle = false,
    this.customBeforeTitle = 'شماره پیگیری',
    this.selectedText = '',
    this.textAddColor = Colors.black,
    required this.statusFunction,
    required this.currencyTitle,
  });

  final String title;
  final String bracesWord;
  final Widget icon;
  final bool hasBottomItem;
  final Function()? onTap;
  final bool isSelectedName;
  final bool hasCustomBeforeTitle;
  final String customBeforeTitle;
  final String selectedText;
  final RxList<SpecificationCostViewModel> itemList;
  final TextEditingController? topTextEditingController;
  final TextEditingController? bottomTextEditingController;
  final String topTextFormFieldLabel;
  final String bottomTextFormFieldLabel;
  final String? titleEdit;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Color textAddColor;
  final Function() statusFunction;
  final String currencyTitle;

  @override
  State<FactorUnofficialSpecificationSelectItem> createState() =>
      _FactorUnofficialSpecificationSelectItemState();
}

class _FactorUnofficialSpecificationSelectItemState
    extends State<FactorUnofficialSpecificationSelectItem> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.secondary,
                          fontFamily: 'IRANSans'),
                      children: <TextSpan>[
                        TextSpan(
                            text: '(${widget.bracesWord})',
                            style: const TextStyle(
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
                        Expanded(
                          child: FittedBox(
                            child: Text(
                              widget.selectedText,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            fit: BoxFit.scaleDown,
                          ),
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
                        const Text(
                          'افزودن',
                          style: TextStyle(),
                        )
                      ],
                    )),
                  Constants.largeHorizontalSpacer,
                ],
              ),
            ),
          ),
// Constants.largeVerticalSpacer,
          if (widget.itemList().isNotEmpty)
            ListView.builder(
              itemCount: widget.itemList().length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            final result = await Get.dialog(
                                FactorUnofficialSpecificationAddOrEditDialog(
                              currencyTitle: widget.currencyTitle,
                              topTextFormFieldLabel:
                                  widget.topTextFormFieldLabel,
                              bottomTextFormFieldLabel:
                                  widget.bottomTextFormFieldLabel,
                              inputFormatters: widget.inputFormatters,
                              textInputType: widget.textInputType,
                              titleDialog: widget.title,
                              specificationCostList: widget.itemList,
                              specificationCostItem: widget.itemList()[index],
                            ));

                            if (result == true) {
                              widget.statusFunction();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 32, bottom: 8, top: 8),
                            child: Row(
                              children: [
                                Text('${index + 1}- '),
                                if (widget.hasCustomBeforeTitle)
                                  Text(
                                    ' ${widget.customBeforeTitle} ',
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                Text(widget.itemList()[index].title,
                                    overflow: TextOverflow.ellipsis),
                                const Text(' : '),
                                Expanded(
                                  child: Text(
                                      '${widget.itemList()[index].price} ${widget.currencyTitle}',
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.dialog(AlertDeleteDialog(
                              title: widget.itemList()[index].title,
                              onPressed: () {
                                setState(() {
                                  widget.itemList
                                      .remove(widget.itemList()[index]);
                                  widget.statusFunction();
                                  Get.back();
                                });
                              },
                              index: index));
                        },
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: 20, start: 20, bottom: 8, top: 8),
                          child: Icon(
                            Icons.delete_outline,
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
    });
  }
}
