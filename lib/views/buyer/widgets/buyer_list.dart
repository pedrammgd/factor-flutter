import 'dart:ui';

import 'package:factor_flutter_mobile/controllers/buyer/buyer_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/buyer/widgets/buyer_list_item.dart';
import 'package:factor_flutter_mobile/views/shared/factor_circular_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BuyerList extends GetView<BuyerController> {
  const BuyerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: FactorCircularProgressIndicator(),
        );
      } else if (controller.buyerListSearch.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                buyerEmptyListIcon,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              Constants.mediumVerticalSpacer,
              const Text(
                'مشتری وجود ندارد',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      } else {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: controller.buyerListSearch.length,
          itemBuilder: (context, index) {
            return BuyerListItem(index: index);
          },
        );
      }
    });
  }
}
