import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list.dart';
import 'package:factor_flutter_mobile/views/list_type_factor/list_type_factor_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/card_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFactorPage extends GetView<HomeFactorController> {
  const HomeFactorPage({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeFactorController());
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Constants.largeVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CardIconWidget(
                onTap: () {
                  Get.to(ListTypeFactorPage(),transition: Transition.noTransition);
                },
                  title: 'فاکتور رسمی', icon: addFactorOfficialIcon),
              Constants.xLargeHorizontalSpacer,
              const CardIconWidget(
                  title: 'فاکتور غیر رسمی', icon: addFactorUnofficialIcon),
            ],
          ),
           FactorList(),
        ],
      ),
    );
  }
}
