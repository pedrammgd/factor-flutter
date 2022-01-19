import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_add_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_card_unofficial_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class FactorUnofficialItem extends GetView<FactorUnofficialController> {
  const FactorUnofficialItem({
    required this.index,required Key key,
  }): super(key: key);

  final int index;


  @override
  Widget build(BuildContext context) {
    return FactorCardUnOfficialWidget(
      itemPopUp: controller.popUpItems,
      onSelectedPopUp: (value) {
        if (value == Constants.editPopUp) {
          editBottomSheet();
        } else {
          controller.removeItem(items);
        }
      },
      title: items.productDescription,
      onTap: () async {
        editBottomSheet();
      },
      itemIndex: itemIndex,
    );
  }

  CustomModalBottomSheet editBottomSheet() {
    return CustomModalBottomSheet.showModalBottomSheet(
      child: FactorUnofficialAddModalBottomSheet(
        factorUnofficialItemList: controller.factorUnofficialItemList,
        factorUnofficialItem: items,
        sharedPreferences: controller.sharedPreferences,
      ),
    );
  }

  FactorUnofficialItemViewModel get items =>
      controller.factorUnofficialItemList[index];

  int get itemIndex => index + 1;
}
