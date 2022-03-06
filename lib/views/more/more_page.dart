import 'package:animate_do/animate_do.dart';
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
            icon: purchaseRecordsIcon,
          ),
          MoreItemWidget(
            title: 'سربرگ فاکتور',
            icon: settingIcon,
            onTap: () {
              Get.toNamed(
                FactorRoutes.factorHeader,
              );
            },
          ),
          MoreItemWidget(
            title: 'مشتری ها',
            icon: cartIcon,
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
            title: 'قالب فاکتور',
            icon: supportIcon,
            onTap: () {
              Get.toNamed(FactorRoutes.customPdfSize);
            },
          ),
          MoreItemWidget(
            title: 'واحد پول',
            icon: messageIcon,
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
            title: 'اشتراک',
            icon: messageIcon,
            onTap: () {
              return Get.toNamed(
                FactorRoutes.subscription,
              );
            },
          ),
          Constants.xxLargeVerticalSpacer,
          Constants.xxLargeVerticalSpacer,
        ],
      ),
    );
  }

  Widget _userInfo(BuildContext context) {
    return Column(
      children: [
        Constants.largeVerticalSpacer,
        DraggableCard(
          child: FadeInRight(
            child: Image.asset(
              goldCupIcon,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Constants.mediumVerticalSpacer,
        const Text(
          'اشتراک طلایی',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Constants.smallVerticalSpacer,
        OutlinedButton(
          onPressed: () {},
          child: Text(
            'ارتقا',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 1.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        )
      ],
    );
  }
}
