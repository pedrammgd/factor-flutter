import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_add_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/bottom_sheet_total_price_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorUnofficialPage extends GetView<FactorUnofficialController> {
  const FactorUnofficialPage();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorUnofficialController());
    return Obx(() {
      return Scaffold(

          appBar: const FactorAppBar(
            height: 56,
            title: Padding(
              padding: EdgeInsets.only(top: 19.0),
              child: Text(
                'فاکتور جدید',
                style: TextStyle(color: Colors.black, fontSize: 20),
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
                  price: controller.price(),
                  taxation: controller.taxation(),
                  discount: controller.discount(),
                  totalPrice: controller.totalPrice(),
                )
              ],
            ),
          ));
    });
  }
}
