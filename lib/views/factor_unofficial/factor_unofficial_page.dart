import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
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
  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;
    final factorHomeList = arguments['factorHomeList'];
    Get.lazyPut(
        () => FactorUnofficialController(factorHomeList: factorHomeList));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return WillPopScope(
      onWillPop: () async {
        final result = await ExitPopUp.showExitPopup(
          title: 'خروج از لیست آیتم فاکتور',
          description: 'در صورت خروج از لیست فاکتور ، تمامی اطلاعات پاک میشود',
        );
        if (result == true) {
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
                    color: Colors.white,
                  )),
            ),
          );
  }

  Widget _body() {
    return FactorBodyAppBarSliver(
      backOnTap: () async {
        final result = await ExitPopUp.showExitPopup(
          title: 'خروج از لیست آیتم فاکتور',
          description: 'در صورت خروج از لیست فاکتور ، تمامی اطلاعات پاک میشود',
        );
        if (result == true) {
          Get.back();
        }
      },
      controller: controller.scrollController,
      body: const FactorUnofficialList(),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text('فاکتور جدید',
            style: TextStyle(
              color: Theme.of(Get.context!).colorScheme.secondary,
            )),
      ),
      bottomWidget: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 34,
          ),
          child: SizedBox(
            height: 45,
            width: double.maxFinite,
            child: CustomBorderButton(
              borderColor: Theme.of(Get.context!).colorScheme.secondary,
              textColor: Theme.of(Get.context!).colorScheme.secondary,
              onPressed: () {
                CustomModalBottomSheet.showModalBottomSheet(
                  color: Theme.of(Get.context!).primaryColor,
                  child: FactorUnofficialAddModalBottomSheet(
                    factorUnofficialItemList:
                        controller.factorUnofficialItemList,
                    factorUnofficialItem: null,
                    sharedPreferences: controller.sharedPreferences,
                  ),
                );
              },
              titleButton: ' افزودن به فاکتور',
              icon: Icon(
                Icons.add,
                color: Theme.of(Get.context!).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validTaxation() {
    return controller.taxation().toStringAsFixed(2).seRagham() + ' ریال';
  }

  String validDiscount() {
    return controller.discount().toStringAsFixed(2).seRagham() + ' ریال';
  }

  String validTotalPrice() {
    // if (controller.totalPrice() > 999999999999999) {
    //   return 'قیمت کل به حروف  نامعتبر';
    // } else {
    return controller.totalPrice().toStringAsFixed(2).seRagham() + ' ریال ';
    // }
  }

  String validTotalWordPrice() {
    if (controller.totalPrice() > 999999999999999) {
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
      return 45;
    }
  }

  Map arguments({
    required RxList<FactorHomeViewModel> factorHomeList,
  }) {
    final map = {};
    map['factorHomeList'] = factorHomeList;
    return map;
  }
}
