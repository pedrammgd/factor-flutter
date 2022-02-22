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
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorUnofficialController());

    return WillPopScope(
      onWillPop: () => ExitPopUp.showExitPopup(
        title: 'خروج از لیست فاکتور',
        description: 'در صورت خروج از لیست فاکتور ، تمامی اطلاعات پاک میشود',
        onPressedOk: () {
          // controller.factorUnofficialItemList.value = [];
          Get.back(result: true);
        },
        context: context,
      ),
      child: Obx(() {
        return Scaffold(
          body: _body(context),
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
      // height: controller.factorUnofficialItemList.isEmpty ? 0 : 245,
      child: Wrap(
        children: [
          InkWell(
            child: BottomSheetTotalPriceWidget(
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

  Widget _body(BuildContext context) {
    return FactorBodyAppBarSliver(
      controller: controller.scrollController,
      body: const FactorUnofficialList(),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text('فاکتور جدید',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
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
              borderColor: Theme.of(context).colorScheme.secondary,
              textColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                CustomModalBottomSheet.showModalBottomSheet(
                  color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validTaxation() {
    if (controller.taxation() > 999999999999) {
      return 'مالیات نامعتبر';
    } else {
      return controller.taxation().toStringAsFixed(2).seRagham() + ' ریال';
    }
  }

  String validDiscount() {
    if (controller.discount() > 999999999999) {
      return 'تخفیف نامعتبر';
    } else {
      return controller.discount().toStringAsFixed(2).seRagham() + ' ریال';
    }
  }

  String validTotalPrice() {
    if (controller.totalPrice() > 999999999999) {
      return 'قیمت کل نامعتبر';
    } else {
      return controller.totalPrice().toStringAsFixed(2).seRagham() + ' ریال';
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
}
