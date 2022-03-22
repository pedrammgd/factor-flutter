import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFactorPage extends GetView<HomeFactorController> {
  const HomeFactorPage({
    required this.scrollController,
    required this.factorHomeList,
    required this.factorHomeListSearch,
  });

  final ScrollController scrollController;
  final RxList<FactorHomeViewModel> factorHomeList;
  final RxList<FactorHomeViewModel> factorHomeListSearch;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeFactorController(
        factorHomeList: factorHomeList,
        factorHomeListSearch: factorHomeListSearch));
    return ListView(
      controller: scrollController,
      children: [
        Constants.xxLargeVerticalSpacer,
        const Padding(
          padding: EdgeInsetsDirectional.only(start: 20),
          child: Text(
            'فاکتور های من',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Constants.mediumVerticalSpacer,
        const FactorList(),
      ],
    );
  }
}
