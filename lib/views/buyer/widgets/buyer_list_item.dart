import 'package:factor_flutter_mobile/controllers/buyer/buyer_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/buyer_card_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
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
      isHaghighi: controller
          .buyerList[index].personBasicInformationViewModel.isHaghighi,
      title: controller
              .buyerList[index].personBasicInformationViewModel.firstName ??
          controller
              .buyerList[index].personBasicInformationViewModel.companyName!,
      editOnTap: () {
        editBottomSheet();
      },
    );
  }

  CustomModalBottomSheet editBottomSheet() {
    return CustomModalBottomSheet.showModalBottomSheet(
      child: BuyerAddOrEditBottomSheet(
        buyerItem: items,
        buyerList: controller.buyerList,
        sharedPreferences: controller.sharedPreferences,
      ),
    );
  }

  BuyerViewModel get items => controller.buyerList[index];
}
