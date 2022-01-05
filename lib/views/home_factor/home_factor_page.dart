import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/card_icon_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFactorPage extends GetView<HomeFactorController> {
  const HomeFactorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeFactorController());
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Constants.largeVerticalSpacer,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CardIconWidget(
                      title: 'فاکتور رسمی', icon: addFactorOfficialIcon),
                  Constants.xLargeHorizontalSpacer,
                  const CardIconWidget(
                      title: 'فاکتور غیر رسمی', icon: addFactorUnofficialIcon),
                ],
              ),
              const FactorList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          barcodeScannerIcon,
          width: 30,
          height: 30,
          fit: BoxFit.contain,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          controller.factorList
              .add(FactorViewModel(title: 'فاکتور جدید3', id: 1));
          controller.saveFactorData();
        },
      ),
    );
  }
}
