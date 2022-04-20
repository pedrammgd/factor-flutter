import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/views/buyer/buyer_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/dragable_widget.dart';
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
          CustomFactorDivider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          Constants.smallVerticalSpacer,
          MoreItemWidget(
            onTap: () {
              Get.toNamed(FactorRoutes.myProfile);
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
          CustomFactorDivider(
            color: Theme.of(context).colorScheme.secondary,
          ),
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
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi) {
              final result = await Get.toNamed(
                FactorRoutes.subscription,
              );

              if (result == true) {
                controller.loadSubscription();
              }
            } else {
              Get.snackbar('خطا در اتصال به اینترنت',
                  'جهت خرید اشتراک ابتدا از اتصال به اینترنت مطمعن شوید',
                  backgroundColor: Colors.yellow.shade800);
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
