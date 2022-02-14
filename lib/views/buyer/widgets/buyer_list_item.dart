import 'package:factor_flutter_mobile/controllers/buyer/buyer_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/buyer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'buyer_add_or_edit_bottom_sheet.dart';

class BuyerListItem extends GetView<BuyerController> {
  const BuyerListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BuyerCardWidget(
      itemPopUp: controller.popUpItems,
      onSelectedPopUp: (value) {
        if (value == Constants.editPopUp) {
          editBottomSheet();
        } else {
          controller.removeItem(items);
        }
      },
      isHaghighi: items.personBasicInformationViewModel.isHaghighi,
      title: items.personBasicInformationViewModel.firstName ??
          items.personBasicInformationViewModel.companyName!,
      editOnTap: () {
        editBottomSheet();
      },
    );
  }

  Future<void> editBottomSheet() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final result = await Get.bottomSheet(
      BuyerAddOrEditBottomSheet(
        buyerItem: items,
        buyerList: controller.buyerList,
        sharedPreferences: controller.sharedPreferences,
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            30,
          ),
        ),
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 0),
    );
    if (result == true) {
      controller.loadBuyerData();
      controller.searchTextEditingController.clear();
    }
  }

  BuyerViewModel get items => controller.buyerListSearch[index];
}
