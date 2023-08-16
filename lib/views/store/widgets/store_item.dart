import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/alert_delete_dialog.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_card_unofficial_widget.dart';
import 'package:factor_flutter_mobile/views/store/widgets/store_add_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/src/extensions.dart';

import '../../../controllers/store/store_controller.dart';
import '../../../models/store/hive/store_item_view_model_hive.dart';

class StoreItem extends GetView<StoreController> {
  const StoreItem({
    required this.index,

  }) ;

  final int index;

  @override
  Widget build(BuildContext context) {
    return FactorCardUnOfficialWidget(
      totalPrice:
          controller.totalPriceItem(items).toStringAsFixed(2).seRagham() +
              ' ${controller.currencyTitle()}',
      itemPopUp: controller.popUpItems,
      onSelectedPopUp: (value) {
        if (value == Constants.editPopUp) {
          editBottomSheet();
        } else {
          Get.dialog(AlertDeleteDialog(
              title: items.productDescription,
              onPressed: () {
                controller.removeItem(index);
                Get.back();
              },
              index: index));
        }
      },
      title: items.productDescription,
      onTap: ()  {
        if(controller.isFromUnofficialFactor){
          Get.back(result: items);
        }else {
          editBottomSheet();
        }
      },
      itemIndex: itemIndex,
    );
  }

  CustomModalBottomSheet editBottomSheet() {
    return CustomModalBottomSheet.showModalBottomSheet(
      color: Theme.of(Get.context!).primaryColor,
      child: StoreAddModalBottomSheet(
        index: index ,
        currencyTitle: controller.currencyTitle(),
        boxStore: controller.boxStore,
        storeItemViewModelHiveItem: items,
        sharedPreferences: controller.sharedPreferences,
      ),
    );
  }

  StoreItemViewModelHive get items => controller.boxStore.value?.getAt(index);
  int get itemIndex => index + 1;
}
