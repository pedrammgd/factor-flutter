import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/hive/factor_view_model_hive.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_add_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/bottom_sheet_total_price_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/exit_popUp.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/expandable/factor_expandable.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class FactorUnofficialPage extends GetView<FactorUnofficialController> {
  const FactorUnofficialPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
            () => FactorUnofficialController());

    return WillPopScope(
      onWillPop: () async {
        if (controller.factorUnofficialItemList.isNotEmpty) {
          final result = await ExitPopUp.showExitPopup(
            title: 'خروج از لیست آیتم فاکتور',
            description:
            'اطلاعات ذخیره نشده ای دارید در صورت خروج از لیست آیتم فاکتور ، اطلاعات شما پاک می شود',
          );
          if (result == true) {
            Get.back();
          }
        } else {
          Get.back();
        }

        return false;
      },
      child: Obx(() {
        return Scaffold(
          body: _body(),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _floatingActionButton(),
          bottomNavigationBar: _bottomNavigationBar(),
        );
      }),
    );
  }

  Widget _bottomNavigationBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: heightBottomSheet(),
      child: Wrap(
        children: [
          InkWell(
            child: BottomSheetTotalPriceWidget(
              statusBracketKeyText: 100,
              bottomButtonOnTap: controller.bottomSheetButtonOnTap,
              taxation: validTaxation(),
              discount: validDiscount(),
              totalPrice: validTotalPrice(),
              totalWordPrice: validTotalWordPrice(),
              onTap: () {
                controller.isExpandedBottomSheet.value =
                !controller.isExpandedBottomSheet.value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton() {
    return controller.factorUnofficialItemList.isEmpty
        ? const SizedBox.shrink()
        : Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 8.0,
      ),
      child: SizedBox(
        width: 30,
        height: 30,
        child: FloatingActionButton(
            onPressed: () {
              controller.isExpandedBottomSheet.value =
              !controller.isExpandedBottomSheet.value;
            },
            child: FactorExpandIcon(
              isExpanded: controller.isExpandedBottomSheet.value,
              color: Theme
                  .of(Get.context!)
                  .primaryColor,
            )),
      ),
    );
  }

  Widget _body() {
    return FactorAppBar.silver(
        customBackButtonFunction: () async {
          if (controller.factorUnofficialItemList.isNotEmpty) {
            final result = await ExitPopUp.showExitPopup(
              title: 'خروج از لیست آیتم فاکتور',
              description:
              'اطلاعات ذخیره نشده ای دارید در صورت خروج از لیست آیتم فاکتور ، اطلاعات شما پاک می شود',
            );
            if (result == true) {
              Get.back();
            }
          } else {
            Get.back();
          }
        },
        controller: controller.scrollController,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text('فاکتور جدید',
              style: TextStyle(
                color: Theme
                    .of(Get.context!)
                    .colorScheme
                    .secondary,
              )),
        ),
        body: const FactorUnofficialList(),
        bottomWidget: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 34,
            ),
            child: SizedBox(
              height: 50,
              width: double.maxFinite,
              child: FactorButton(
                onPressed: () {
                  CustomModalBottomSheet.showModalBottomSheet(
                    color: Theme
                        .of(Get.context!)
                        .primaryColor,
                    child: FactorUnofficialAddModalBottomSheet(
                      factorUnofficialItemList:
                      controller.factorUnofficialItemList,
                      factorUnofficialItem: null,
                      sharedPreferences: controller.sharedPreferences,
                      currencyTitle: controller.currencyTitle(),
                    ),
                  );
                },
                titleButton: ' افزودن به فاکتور',
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        ));
    // return FactorBodyAppBarSliver(
    //   backOnTap: () async {
    //     if (controller.factorUnofficialItemList.isNotEmpty) {
    //       final result = await ExitPopUp.showExitPopup(
    //         title: 'خروج از لیست آیتم فاکتور',
    //         description:
    //             'اطلاعات ذخیره نشده ای دارید در صورت خروج از لیست آیتم فاکتور ، اطلاعات شما پاک می شود',
    //       );
    //       if (result == true) {
    //         Get.back();
    //       }
    //     } else {
    //       Get.back();
    //     }
    //   },
    //   controller: controller.scrollController,
    //   body: const FactorUnofficialList(),
    //   title: Padding(
    //     padding: const EdgeInsets.only(top: 5),
    //     child: Text('فاکتور جدید',
    //         style: TextStyle(
    //           color: Theme.of(Get.context!).colorScheme.secondary,
    //         )),
    //   ),
    //   bottomWidget: PreferredSize(
    //     preferredSize: const Size.fromHeight(45),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 34,
    //       ),
    //       child: SizedBox(
    //         height: 45,
    //         width: double.maxFinite,
    //         child: CustomBorderButton(
    //           onPressed: () {
    //             CustomModalBottomSheet.showModalBottomSheet(
    //               color: Theme.of(Get.context!).primaryColor,
    //               child: FactorUnofficialAddModalBottomSheet(
    //                 factorUnofficialItemList:
    //                     controller.factorUnofficialItemList,
    //                 factorUnofficialItem: null,
    //                 sharedPreferences: controller.sharedPreferences,
    //                 currencyTitle: controller.currencyTitle(),
    //               ),
    //             );
    //           },
    //           titleButton: ' افزودن به فاکتور',
    //           icon: Icon(
    //             Icons.add,
    //             color: Theme.of(Get.context!).colorScheme.secondary,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  String validTaxation() {
    return controller.taxation().toStringAsFixed(2).seRagham() +
        ' ${controller.currencyTitle()}';
  }

  String validDiscount() {
    return controller.discount().toStringAsFixed(2).seRagham() +
        ' ${controller.currencyTitle()}';
  }

  String validTotalPrice() {
    return controller.totalPrice().toStringAsFixed(2).seRagham() +
        ' ${controller.currencyTitle()}';
  }

  String validTotalWordPrice() {
    if (controller.totalPrice() > 999999999999999) {
      return 'قیمت کل به حروف  نامعتبر';
    } else {
      return '${controller.totalPrice().toInt()}'.toWord() +
          ' ${controller.currencyTitle()}';
    }
  }

  double heightBottomSheet() {
    if (controller.factorUnofficialItemList.isEmpty) {
      return 0;
    } else if (controller.isExpandedBottomSheet.value) {
      return 195;
    } else {
      return 45;
    }
  }

}
