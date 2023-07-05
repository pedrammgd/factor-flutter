import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:factor_flutter_mobile/controllers/factor_base/factor_base_controller.dart';
import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/views/home_factor/home_factor_page.dart';
import 'package:factor_flutter_mobile/views/list_type_factor/list_type_factor_page.dart';
import 'package:factor_flutter_mobile/views/more/more_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iran_appmarket/iran_appmarket.dart';

class FactorBasePage extends GetView<FactorBaseController> {
  FactorBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorBaseController());
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (controller.currentIndex.value == 1) {
            controller.currentIndex.value = 0;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          // appBar: FactorAppBar(
          //
          //   textEditingController: controller.searchEditingController,
          //   leadingWidget: const SizedBox.shrink(),
          //   onChangedSearchBar: controller.searchFactorHome,
          //   // hasBarcodeButton: true,
          //   height: 70,
          //   onPressedClearButton: () {
          //     // Get.find<HomeFactorController>().loadFactorData();
          //     Get.find<HomeFactorController>().openBoxHive();
          //   },
          //   title: Padding(
          //     padding: const EdgeInsets.only(top: 15),
          //     child: _getShowTitle().elementAt(controller.currentIndex.value),
          //   ),
          //   hasSearchBar:
          //       _getShowSearchBar().elementAt(controller.currentIndex.value),
          // ),
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
            child: Column(
              children: [
                if(controller.currentIndex.value ==0)
                CarouselSlider.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                        child: Container(
                            decoration: BoxDecoration(
                            color: itemIndex ==1? Colors.brown.shade400: Colors.lightBlue.shade400,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            margin: EdgeInsets.all(20),height: 230,
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Row(
                                children: [
                                   Text(
                                     itemIndex ==1?'کافه پر': 'تسک پر',
                                    style: TextStyle(color: Colors.white,fontSize: 24),
                                  ),
                              // Constants.mediumHorizontalSpacer,
                                  if(itemIndex ==0)
                                  Transform.scale(
                                    scale: 2,
                                    child: Image.asset(
                                      taskParLogo,
                                      width: 50,
                                      height: 50,
                                      // fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            Constants.mediumVerticalSpacer,
                            Text(
                              itemIndex ==1?'انواع قهوه و لوازم قهوه با کافی پر ارسال رایگان ': 'با اپلیکیشن تسک پر به راحتی تسک بزن',
                                style: TextStyle(color: Colors.white,fontSize: 14),

                            ),
                            Constants.mediumVerticalSpacer,

                            FactorButton(onPressed: (){
                              // IranAppMarket.showDeveloperApps(AppMarket.cafeBazaar, '568414623994');
                              IranAppMarket.showDeveloperApps(
                                  AppMarket.myket, 'com.example.task_par');

                            },
                              borderColor: Colors.white,
                              textColor: Colors.white,
                              titleButton: 'نصب',
                            ),
                          ],
                        ),
                        ),
                      ), options: CarouselOptions(),
                ),
                _getPageList().elementAt(controller.currentIndex.value),
              ],
            ),
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
                // FocusManager.instance.primaryFocus?.unfocus();
                Get.toNamed(FactorRoutes.listTypeFactor,
                    arguments: const ListTypeFactorPage().arguments(
                        factorHomeList: controller.factorHomeListHive,
                        adsViewModel: controller.adsViewModel,
                        isLoadingAd: controller.isLoadingAd));
              },
            ),
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
          factorHomeListHiveSearch: controller.factorHomeListHiveSearch,
          factorHomeListHive: controller.factorHomeListHive),
      const MorePage(),
    ];
  }

  List<bool> _getShowSearchBar() {
    return [true, false];
  }

  List<Widget> _getShowTitle() {
    return [
      const SizedBox.shrink(),
      Text(
        'داشبورد',
        style: TextStyle(color: Theme.of(Get.context!).colorScheme.secondary),
      ),
    ];
  }
}
