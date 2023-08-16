import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_item.dart';
import 'package:factor_flutter_mobile/views/store/widgets/store_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/store/store_controller.dart';

class StoreList extends GetView<StoreController> {
  const StoreList({Key? key}) : super(key: key);

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
        } else if (controller.boxStore.value!.isEmpty) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(top: 100),
            child: ListView(
              children: [
                Image.asset(
                  warehouseIcon,
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: 20),
                    child: Text('انبار خالی است'),
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(

            padding: const EdgeInsets.only(bottom: 50, top: 10),
            itemCount: controller.boxStore.value!.length,
            itemBuilder: (context, index) {
              return StoreItem(
                // key: ValueKey(controller.boxStore.value?.getAt(index)),
                index: index,
              );
            },
          );
        }
      },
    );
  }
}
