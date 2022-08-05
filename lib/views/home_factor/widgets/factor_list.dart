import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorList extends GetView<HomeFactorController> {
  const FactorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        } else if (controller.factorHomeListSearch.isEmpty) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(top: 90),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  emptyList,
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.only(top: 20),
                  child: Text('فاکتوری وجود ندارد'),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 40),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.factorHomeListSearch.length,
              itemBuilder: (context, index) {
                return FactorListItem(
                  factorItem: controller.factorHomeListSearch[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}
