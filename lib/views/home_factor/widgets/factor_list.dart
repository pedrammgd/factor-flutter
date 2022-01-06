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
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.xLargeVerticalSpacer,
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 20),
            child: Text(
              'فاکتور های من',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Constants.mediumVerticalSpacer,
          _conditionFactorList(context),
        ],
      ),
    );
  }

  Widget _conditionFactorList(BuildContext context) {
    if (controller.isLoading.value) {
      return   Padding(
        padding: const EdgeInsetsDirectional.only(top: 100),
        child: Center(
            child:
            SizedBox(
                height: 15,
                 width: 15,
                child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,))
      ));
    } else if (controller.factorList.isEmpty) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(top: 100),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              emptyList,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            )),
            const Padding(
              padding: EdgeInsetsDirectional.only(top: 20),
              child: Text('فاکتوری وجود ندارد'),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.factorList.length,
          itemBuilder: (context, index) {
            return  FactorListItem(factorItem: controller.factorList[index],);
          },
        ),
      );
    }
  }


}
