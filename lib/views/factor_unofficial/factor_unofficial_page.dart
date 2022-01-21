import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_add_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/bottom_sheet_total_price_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/exit_popUp.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/expandable/factor_expandable.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_sliver_appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class FactorUnofficialPage extends GetView<FactorUnofficialController> {
  const FactorUnofficialPage();

  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;
    final isBeforeFactor = arguments['isBeforeFactor'];
    Get.lazyPut(
        () => FactorUnofficialController(isBeforeFactor: isBeforeFactor));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return WillPopScope(
      onWillPop: () => ExitPopUp.showExitPopup(
        title: 'خروج از لیست فاکتور',
        description: 'در صورت خروج از لیست فاکتور ، تمامی اطلاعات پاک میشود',
        onPressedOk: () {
          // controller.factorUnofficialItemList.value = [];
          Get.back(result: true);
        },
      ),
      child: Obx(() {
        return Scaffold(
          body: FactorBodyAppBarSliver(
            body: const FactorUnofficialList(),
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child:
                  Text(controller.isBeforeFactor ? 'پیش فاکتور' : 'فاکتور جدید',
                      style: const TextStyle(
                        color: Colors.black,
                      )),
            ),
            bottomWidget: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 34,
                ),
                child: SizedBox(
                  height: 40,
                  width: double.maxFinite,
                  child: CustomBorderButton(
                    onPressed: () {
                      CustomModalBottomSheet.showModalBottomSheet(
                        child: FactorUnofficialAddModalBottomSheet(
                          factorUnofficialItemList:
                              controller.factorUnofficialItemList,
                          factorUnofficialItem: null,
                          sharedPreferences: controller.sharedPreferences,
                        ),
                      );
                    },
                    titleButton: ' افزودن به فاکتور',
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: controller.factorUnofficialItemList.isEmpty
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
                          // CustomModalBottomSheet.showModalBottomSheet(
                          //   child: FactorUnofficialAddModalBottomSheet(
                          //     factorUnofficialItemList:
                          //         controller.factorUnofficialItemList,
                          //     factorUnofficialItem: null,
                          //     sharedPreferences: controller.sharedPreferences,
                          //   ),
                          // );
                        },
                        child: FactorExpandIcon(
                          isExpanded: controller.isExpandedBottomSheet.value,
                          color: Colors.white,
                        )),
                  ),
                ),
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: heightBottomSheet(),
            // height: controller.factorUnofficialItemList.isEmpty ? 0 : 245,
            child: Wrap(
              children: [
                InkWell(
                  child: BottomSheetTotalPriceWidget(
                    price: validPrice(),
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
          ),
        );
      }),
    );
  }

  String validPrice() {
    if (controller.price() > 999999999999) {
      return 'قیمت نامعتبر';
    } else {
      return '${controller.price()}'.seRagham() + ' ریال';
    }
  }

  String validTaxation() {
    if (controller.taxation() > 999999999999) {
      return 'مالیات نامعتبر';
    } else {
      return '${controller.taxation()}'.seRagham() + ' ریال';
    }
  }

  String validDiscount() {
    if (controller.discount() > 999999999999) {
      return 'تخفیف نامعتبر';
    } else {
      return '${controller.discount()}'.seRagham() + ' ریال';
    }
  }

  String validTotalPrice() {
    if (controller.totalPrice() > 999999999999) {
      return 'قیمت کل نامعتبر';
    } else {
      return '${controller.totalPrice()}'.seRagham() + ' ریال';
    }
  }

  String validTotalWordPrice() {
    if (controller.totalPrice() > 999999999999) {
      return 'قیمت کل به حروف  نامعتبر';
    } else {
      return '${controller.totalPrice().toInt()}'.toWord() + ' ریال ';
    }
  }

  double heightBottomSheet() {
    if (controller.factorUnofficialItemList.isEmpty) {
      return 0;
    } else if (controller.isExpandedBottomSheet.value) {
      return 225;
    } else {
      return 50;
    }
  }

  Map arguments({required bool isBeforeFactor}) {
    final map = {};
    map['isBeforeFactor'] = isBeforeFactor;
    return map;
  }
}
