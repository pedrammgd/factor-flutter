import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorUnofficialList extends GetView<FactorUnofficialController> {
  const FactorUnofficialList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(top: 100),
            child: Center(
              child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ),
          );
        } else if (controller.factorUnofficialItemList.isEmpty) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(top: 100),
            child: Column(
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
            padding: const EdgeInsetsDirectional.only(bottom: 10, top: 30),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.factorUnofficialItemList.length,
              itemBuilder: (context, index) {
                return FactorUnofficialItem(
                    factorUnofficialItems:
                        controller.factorUnofficialItemList[index]);
              },
            ),
          );
        }
      },
    );
  }
}
