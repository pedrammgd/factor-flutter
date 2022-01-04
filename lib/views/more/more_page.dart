import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/more_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends GetView<MoreController> {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MoreController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _userInfo(context),
              CustomFactorDivider(
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
              Constants.smallVerticalSpacer,
              const MoreItemWidget(
                title: 'لیست پرداخت ها',
                icon: purchaseRecordsIcon,
              ),
              const MoreItemWidget(
                title: 'خرید اشتراک',
                icon: cartIcon,
              ),
              Constants.smallVerticalSpacer,
              CustomFactorDivider(
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
              Constants.smallVerticalSpacer,
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
        ),
      ),
    );
  }

  Widget _userInfo(BuildContext context) {
    return Column(
      children: [
        Constants.mediumVerticalSpacer,
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Switch(value: controller.isDark.value, onChanged: (value) {

                controller.isDark.value = value;

                controller.changeTheme();
                controller.saveTheme();
              },),
              Constants.mediumHorizontalSpacer,
            ],
          );
        }),
        Constants.xLargeVerticalSpacer,
        Image.asset(
          goldCupIcon,
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
        Constants.mediumVerticalSpacer,
        const Text('اشتراک طلایی',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        Constants.smallVerticalSpacer,
        OutlinedButton(
          onPressed: () {}, child: Text('ارتقا', style: TextStyle(color: Theme
            .of(context)
            .colorScheme
            .secondary,),),
          style: OutlinedButton.styleFrom(

            side: BorderSide(width: 1.0, color: Theme
                .of(context)
                .colorScheme
                .secondary,),
          ),

        )
      ],
    );
  }
}
