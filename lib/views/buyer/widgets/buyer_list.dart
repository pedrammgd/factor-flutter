import 'package:factor_flutter_mobile/controllers/buyer/buyer_controller.dart';
import 'package:factor_flutter_mobile/views/buyer/widgets/buyer_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyerList extends GetView<BuyerController> {
  const BuyerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        itemCount: controller.buyerList.length,
        itemBuilder: (context, index) {
          return BuyerListItem(index: index);
        },
      );
    });
  }
}
