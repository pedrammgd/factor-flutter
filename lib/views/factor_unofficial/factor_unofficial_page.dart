import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_add_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/bottom_sheet_total_price_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/exit_popUp.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
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
      onWillPop: () => ExitPopUp.showExitPopup(),
      child: Obx(() {
        return Scaffold(
            appBar: FactorAppBar(
              height: 56,
              title: Padding(
                padding: const EdgeInsets.only(top: 19.0),
                child: Text(
                  controller.isBeforeFactor ? 'پیش فاکتور' : 'فاکتور جدید',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            body: const FactorUnofficialList(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FloatingActionButton(
                onPressed: () {
                  print(validTotalPrice());
                  CustomModalBottomSheet.showModalBottomSheet(
                    child: FactorUnofficialAddModalBottomSheet(
                      factorUnofficialItemList:
                          controller.factorUnofficialItemList,
                      factorUnofficialItem: null,
                      sharedPreferences: controller.sharedPreferences,
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: controller.factorUnofficialItemList.isEmpty ? 0 : 240,
              child: Wrap(
                children: [
                  BottomSheetTotalPriceWidget(
                    price: validPrice(),
                    taxation: validTaxation(),
                    discount: validDiscount(),
                    totalPrice: validTotalPrice(),
                    totalWordPrice: validTotalWordPrice(),
                  )
                ],
              ),
            ));
      }),
    );
  }

  String validPrice() {
    if (controller.price() > 999999999999) {
      return 'قیمت نامعتبر';
    } else {
      return '${controller.price()}'.seRagham()  + ' ریال';
    }
  }

  String validTaxation() {
    if (controller.taxation() > 999999999999) {
      return 'مالیات نامعتبر';
    } else {
      return '${controller.taxation()} ریال'.seRagham();
    }
  }

  String validDiscount() {
    if (controller.discount() > 999999999999) {
      return 'تخفیف نامعتبر';
    } else {
      return '${controller.discount()} ریال'.seRagham();
    }
  }

  String validTotalPrice() {
    if (controller.totalPrice() > 999999999999) {
      return 'قیمت کل نامعتبر';
    } else {
      return '${controller.totalPrice()} ریال'.seRagham();
    }
  }

  String validTotalWordPrice() {
    if (controller.totalPrice() > 999999999999) {
      return 'قیمت کل به حروف  نامعتبر';
    } else {
      return '${controller.totalPrice().toInt()}'.toWord() + ' ریال ';
    }
  }

  Map arguments({required bool isBeforeFactor}) {
    final map = {};
    map['isBeforeFactor'] = isBeforeFactor;
    return map;
  }
}
