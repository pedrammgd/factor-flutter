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
          const MoreItemWidget(
            title: 'تنظیمات',
            icon: settingIcon,
          ),
          const MoreItemWidget(
            title: 'پیام ها',
            icon: messageIcon,
          ),
          const MoreItemWidget(
            title: 'پشتیبانی',
            icon: supportIcon,
          ),
        ],
      ),
    );
  }

  Widget _userInfo(BuildContext context) {
    return Column(
      children: [
        // Constants.mediumVerticalSpacer,
        // Obx(() {
        //   return Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Constants.mediumHorizontalSpacer,
        //
        //       GestureDetector(
        //           onTap: () {
        //             controller.isDark.value = !controller.isDark.value;
        //
        //             controller.changeTheme();
        //             controller.saveTheme();
        //           },
        //           child: Image.asset(
        //             controller.isDark.value ? lightIcon : darkIcon,
        //             height: 30,
        //             width: 30,
        //             color:
        //                 controller.isDark.value ? Colors.white : Colors.black,
        //           )),
        //     ],
        //   );
        // }),
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
