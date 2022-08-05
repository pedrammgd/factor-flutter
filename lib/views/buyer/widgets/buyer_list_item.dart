import 'package:factor_flutter_mobile/controllers/buyer/buyer_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/alert_delete_dialog.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/buyer_card_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'buyer_add_or_edit_bottom_sheet.dart';

class BuyerListItem extends GetView<BuyerController> {
  const BuyerListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BuyerCardWidget(
      numberItem: index + 1,
      itemPopUp: controller.popUpItems,
      onSelectedPopUp: (value) {
        if (value == Constants.editPopUp) {
          _editBottomSheet();
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          Get.closeAllSnackbars();
          Get.dialog(AlertDeleteDialog(
              title: items.personBasicInformationViewModel.fullName ?? 'مشتری',
              onPressed: () {
                controller.removeItem(items);
                Get.back();
              },
              index: index));
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      isHaghighi: items.personBasicInformationViewModel.isHaghighi,
      title: (items.personBasicInformationViewModel.fullName) ??
          items.personBasicInformationViewModel.companyName ??
          '',
      onTap: () {
        if (controller.isEnterFromSpecificFactor) {
          Get.back(result: items);
        } else {
          _editBottomSheet();
        }
      },
    );
  }

  Future<void> _editBottomSheet() async {
    Get.closeAllSnackbars();
    FocusManager.instance.primaryFocus?.unfocus();
    final result = await Get.bottomSheet(
      BuyerAddOrEditBottomSheet(
        buyerItem: items,
        buyerList: controller.buyerList,
        sharedPreferences: controller.sharedPreferences,
      ),
      backgroundColor: Theme.of(Get.context!).primaryColor,
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
      controller.isShowFoundSearch.value = false;
      controller.loadBuyerData();
      controller.searchTextEditingController.clear();
    }
  }

  BuyerViewModel get items => controller.buyerListSearch[index];
}
