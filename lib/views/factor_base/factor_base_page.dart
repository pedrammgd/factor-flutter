import 'package:animate_do/animate_do.dart';
import 'package:factor_flutter_mobile/controllers/factor_base/factor_base_controller.dart';
import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/views/list_type_factor/list_type_factor_page.dart';
import 'package:factor_flutter_mobile/views/more/more_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_factor/home_factor_page.dart';

class FactorBasePage extends GetView<FactorBaseController> {
  FactorBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorBaseController());
    return Obx(() {
      return Scaffold(
        appBar: FactorAppBar(
          onChangedSearchBar: controller.searchFactorHome,
          hasBarcodeButton: true,
          hasBackButton: false,
          height: 70,
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'داشبورد',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          hasTitle: _getShowTitle().elementAt(controller.currentIndex.value),
          hasSearchBar:
              _getShowSearchBar().elementAt(controller.currentIndex.value),
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: FadeInUp(
          delay: const Duration(milliseconds: 1000),
          child: CustomBottomNavigationBar(
            onItemSelected: (value) {
              controller.currentIndex.value = value;
              if (value == 1) {
                Get.find<MoreController>().loadSubscription();
              }
            },
            selectedIndex: controller.currentIndex.value,
            items: factorBottomNavigationBarItem,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: _getPageList().elementAt(controller.currentIndex.value),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 10),
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.toNamed(FactorRoutes.listTypeFactor,
                  arguments: const ListTypeFactorPage()
                      .arguments(factorHomeList: controller.factorHomeList));
            },
          ),
        ),
      );
    });
  }

  final List<FactorBottomNavigationBarItem> factorBottomNavigationBarItem =
      <FactorBottomNavigationBarItem>[
    FactorBottomNavigationBarItem(icon: homeIcon),
    FactorBottomNavigationBarItem(icon: moreIcon)
  ];

  List<Widget> _getPageList() {
    return [
      HomeFactorPage(
          factorHomeListSearch: controller.factorHomeListSearch,
          scrollController: controller.scrollController,
          factorHomeList: controller.factorHomeList),
      const MorePage(),
    ];
  }

  List<bool> _getShowSearchBar() {
    return [true, false];
  }

  List<bool> _getShowTitle() {
    return [false, true];
  }
}
