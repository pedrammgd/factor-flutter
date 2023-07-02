import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFactorPage extends GetView<HomeFactorController> {
  const HomeFactorPage({
    required this.factorHomeList,
    required this.factorHomeListSearch,
  });

  final RxList<FactorHomeViewModel> factorHomeList;
  final RxList<FactorHomeViewModel> factorHomeListSearch;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeFactorController(
        // factorHomeList: factorHomeList,
        // factorHomeListSearch: factorHomeListSearch
        ));
    return ListView(
      // shrinkWrap: true,

      children: [
        Constants.largeVerticalSpacer,
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(15),
                  child: Text(
                    'فاکتور های من',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: greenColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        Constants.mediumVerticalSpacer,
        const FactorList(),
      ],
    );
  }
}
