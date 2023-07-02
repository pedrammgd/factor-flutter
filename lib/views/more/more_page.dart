import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_apps/device_apps.dart';
import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/views/buyer/buyer_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/dragable_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_snack_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/more_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends GetView<MoreController> {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MoreController());
    return SingleChildScrollView(
      child: Column(
        children: [
          _userInfo(context),
          const CustomFactorDivider(),
          Constants.smallVerticalSpacer,
          MoreItemWidget(
            onTap: () async {
              //launches comment bazaar dialog
              // CafebazaarMarket.setComment().whenComplete(() => print('aaa'));
              // if (CafebazaarMarket.isUpdateAvailable() != null) {
              //   print('update');
              // } else {
              //   print('noUpdate');
              // }
              // Cafebazaar.commentOnBazaar().then((value) => print('value'));
              // final _bazaar = CafebazaarFlutter.instance;
              // await _bazaar
              //     .openCommentForm('com.example.factor_flutter_mobile');
              // print('USER BACK TO YOUR APP');

              Get.toNamed(
                FactorRoutes.myProfile,
              );
            },
            title: 'مشخصات من',
            icon: myProfileIcon,
          ),
          MoreItemWidget(
            title: 'سربرگ فاکتور',
            icon: documentHeaderIcon,
            onTap: () {
              Get.toNamed(
                FactorRoutes.factorHeader,
              );
            },
          ),
          MoreItemWidget(
            title: 'مشتری ها',
            icon: buyerEmptyListIcon,
            onTap: () {
              Get.toNamed(FactorRoutes.buyer,
                  arguments: const BuyerPage()
                      .arguments(isEnterFromSpecificFactor: false));
            },
          ),
          Constants.smallVerticalSpacer,
          const CustomFactorDivider(),
          Constants.smallVerticalSpacer,
          MoreItemWidget(
            title: 'نمودار فاکتور',
            icon: chartIcon,
            onTap: () {
              Get.toNamed(FactorRoutes.chart);
            },
          ),
          MoreItemWidget(
            title: 'قالب فاکتور',
            icon: formatSizeIcon,
            onTap: () {
              Get.toNamed(FactorRoutes.customPdfSize);
            },
          ),
          MoreItemWidget(
            title: 'واحد پول',
            icon: moneyIcon,
            onTap: () {
              return Get.toNamed(
                FactorRoutes.currency,
              );
            },
          ),
          Obx(() {
            return MoreItemWidget(
              onTap: () {
                controller.isDark.value = !controller.isDark.value;

                controller.changeTheme();
                controller.saveTheme();
              },
              title: controller.isDark.value ? 'حالت روز' : 'حالت شب',
              icon: controller.isDark.value ? lightIcon : darkIcon,
            );
          }),
          MoreItemWidget(
            title: 'پشتیبانی',
            icon: supportIcon,
            onTap: () {
              Get.defaultDialog(
                  title: 'پشتیبانی',
                  middleText:
                      'در صورت هر گونه مشکل در برنامه فاکتور پر با ما در ارتباط باشید (avacompanydeveloper@gmail.com) ',
                  textCancel: 'باشه');
            },
          ),
          Constants.xxLargeVerticalSpacer,
          Constants.xxLargeVerticalSpacer,
          Constants.mediumVerticalSpacer,
        ],
      ),
    );
  }

  Widget _userInfo(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () async {
            //Todo todo
            // bool isBazzarInstalled =
            //     await DeviceApps.isAppInstalled('com.farsitel.bazaar');
            // bool isMyketInstalled =
            //     await DeviceApps.isAppInstalled('ir.mservices.market');

            var connectivityResult = await (Connectivity().checkConnectivity());
            final bool isConnectedInternet =
                connectivityResult == ConnectivityResult.mobile ||
                    connectivityResult == ConnectivityResult.wifi;
            if (isConnectedInternet) {
              final result = await Get.toNamed(
                FactorRoutes.subscription,
              );

              if (result == true) {
                controller.loadSubscription();
              }
            } else {
              // if (!isConnectedInternet) {
              FactorSnackBar.getxSnackBar(
                  title: 'خطا در اتصال به اینترنت',
                  message:
                      'جهت خرید اشتراک ابتدا از اتصال به اینترنت مطمعن شوید',
                  backgroundColor: Colors.yellow.shade800,
                  icon: controller.subscriptionIcon().value);
              // } else {
              //   FactorSnackBar.getxSnackBar(
              //       title: 'خطا در اتصال به مایکت',
              //       message:
              //           'جهت خرید اشتراک ابتدا برنامه را از دستگاه خود حذف کنید و از مایکت دانلود کنید',
              //       backgroundColor: Colors.yellow.shade800,
              //       icon: controller.subscriptionIcon().value);
              // }
            }
          },
          child: Column(
            children: [
              Constants.largeVerticalSpacer,
              DraggableCard(
                child: FadeInRight(
                  child: Image.asset(
                    controller.subscriptionIcon().value,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Constants.mediumVerticalSpacer,
              Text(
                controller.subscriptionTitle().value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Constants.smallVerticalSpacer,
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    controller.subscriptionTextButton().value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
