import 'package:animate_do/animate_do.dart';
import 'package:factor_flutter_mobile/controllers/factor_base/factor_base_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/more/more_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/scroll_to_hide_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../home_factor/home_factor_page.dart';

class FactorBasePage extends GetView<FactorBaseController> {
   FactorBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorBaseController());
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() {
        return FadeInUp(
          delay: const Duration(milliseconds: 1000),
          child: ScrollToHideWidget(
            scrollController: controller.scrollController,
            height: 55,
            child: CustomBottomNavigationBar(
              onItemSelected: (value) {
                controller.currentIndex.value = value;
              },
              selectedIndex: controller.currentIndex.value,
              items: factorBottomNavigationBarItem,
            ),

          ),
        );
      }),
      body: Obx(() {
        return SafeArea(
          bottom: false,
          child: _getPageList().elementAt(controller.currentIndex.value),
        );
      }),
      floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.only(
              bottom: 10),
          child: FloatingActionButton(

            child: Image.asset(
              barcodeScannerIcon,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            onPressed: () {
              // controller.factorList
              //     .add(FactorViewModel(title: 'فاکتور جدید3', id: 1));
              // controller.saveFactorData();
            },
          ),
        )

    );
  }


  final List<FactorBottomNavigationBarItem> factorBottomNavigationBarItem =
  <FactorBottomNavigationBarItem>[
    FactorBottomNavigationBarItem(icon: homeIcon),
    FactorBottomNavigationBarItem(icon: moreIcon)
  ];

   List<Widget> _getPageList() {
    return [
      HomeFactorPage(scrollController: controller.scrollController,),
      const MorePage(),
    ];
  }
}