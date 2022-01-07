import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/card_icon_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTypeFactorPage extends StatelessWidget {
  const ListTypeFactorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FactorAppBar(
        height: 56,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardIconWidget(
                onTap: () {},
                title: 'فاکتور رسمی',
                icon: addFactorOfficialIcon),
            Constants.xLargeHorizontalSpacer,
            CardIconWidget(
                onTap: () {
                  Get.toNamed(FactorRoutes.factorUnofficial);
                },
                title: 'فاکتور غیر رسمی',
                icon: addFactorUnofficialIcon),
          ],
        ),
      ),
    );
  }
}