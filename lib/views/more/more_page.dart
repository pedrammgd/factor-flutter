import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/more_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _userInfo(),
              CustomFactorDivider(
                color: dividerColor,
              ),
              Constants.smallVerticalSpacer,
              const MoreItemWidget(title: 'لیست پرداخت ها',icon:purchaseRecordsIcon ,),
              const MoreItemWidget(title: 'خرید اشتراک',icon: cartIcon,),
              Constants.smallVerticalSpacer,
              CustomFactorDivider(
                color: dividerColor,
              ),
              Constants.smallVerticalSpacer,
              const MoreItemWidget(title: 'تنظیمات',icon: settingIcon,),
              const MoreItemWidget(title: 'پیام ها',icon: messageIcon,),
              const MoreItemWidget(title: 'پشتیبانی',icon: supportIcon,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Column(
      children: [
        Constants.mediumVerticalSpacer,
        Row(
          children: [
            Constants.mediumHorizontalSpacer,
            const Icon(Icons.more_vert)
          ],
        ),
        Constants.xLargeVerticalSpacer,
        Image.asset(
          goldCupIcon,
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
        Constants.mediumVerticalSpacer,
        const Text('اشتراک طلایی',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
        Constants.smallVerticalSpacer,
        OutlinedButton(onPressed: () {}, child: const Text('ارتقا',style: TextStyle(color: Colors.black),),
          style: OutlinedButton.styleFrom(

            side: const BorderSide(width: 1.0, color: Colors.black),
          ),

        )
      ],
    );
  }
}
