import 'package:animate_do/animate_do.dart';
import 'package:factor_flutter_mobile/controllers/list_type_factor_page/list_type_factor_page_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/factor_unofficial_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/card_icon_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTypeFactorPage extends GetView<ListTypeFactorPageController> {
  const ListTypeFactorPage({Key? key}) : super(key: key);

  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;
    final factorHomeList = arguments['factorHomeList'];

    Get.lazyPut<ListTypeFactorPageController>(
        () => ListTypeFactorPageController(factorHomeList: factorHomeList));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return Scaffold(
      appBar: const FactorAppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 13,
                    spacing: 3,
                    children: [
                      Constants.veryTinyHorizontalSpacer,
                      FadeInRight(
                        child: CardIconWidget(
                            comingSoon: true,
                            iconColor: Theme.of(context).colorScheme.secondary,
                            onTap: () {},
                            title: 'فاکتور رسمی',
                            icon: addFactorOfficialIcon),
                      ),
                      Constants.smallHorizontalSpacer,
                      FadeInLeft(
                        child: CardIconWidget(
                          iconColor: Theme.of(context).colorScheme.secondary,
                          onTap: () {
                            Get.toNamed(FactorRoutes.factorUnofficial,
                                arguments: FactorUnofficialPage().arguments(
                                    factorHomeList: controller.factorHomeList));
                          },
                          title: 'فاکتور غیر رسمی',
                          icon: addFactorUnofficialIcon,
                          infoOnTap: () {
                            Get.defaultDialog(
                                title: 'فاکتور غیر رسمی',
                                middleText:
                                    'شامل فاکتور فروش ، فاکتور خرید ، فاکتور خدمات، فاکتور فروشگاهی و...... می باشد',
                                textCancel: 'فهمیدم');
                          },
                        ),
                      ),
                      Constants.veryTinyHorizontalSpacer,
                    ],
                  ),
                ],
              ),
            ),
            FadeInUp(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Card(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5, top: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          child: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                          onTap: () {},
                        ),
                      ),
                      const Center(child: Text('تبلیغات')),
                    ],
                  ),
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Map arguments({
    required RxList<FactorHomeViewModel> factorHomeList,
  }) {
    final map = {};
    map['factorHomeList'] = factorHomeList;

    return map;
  }
}
