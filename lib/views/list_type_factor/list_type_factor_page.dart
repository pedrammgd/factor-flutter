import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:factor_flutter_mobile/controllers/list_type_factor_page/list_type_factor_page_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/factor_unofficial_page.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/card_icon_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTypeFactorPage extends GetView<ListTypeFactorPageController> {
  const ListTypeFactorPage({Key? key}) : super(key: key);

  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;
    final factorHomeList = arguments['factorHomeList'];

    Get.put<ListTypeFactorPageController>(
        ListTypeFactorPageController(factorHomeList: factorHomeList));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return Scaffold(
      appBar: const FactorAppBar(),
      body: Center(
        child: Obx(() {
          return Column(
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
                              iconColor:
                                  Theme.of(context).colorScheme.secondary,
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
                                      factorHomeList:
                                          controller.factorHomeList));
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
              if (!controller.isLoadingAd.value)
                FadeInUp(
                  child: CarouselSlider.builder(
                    itemCount: controller.adsViewModel.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Padding(
                      padding:
                          const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                              onTap: () async {
                                if (!await launch(controller
                                    .adsViewModel[itemIndex].linkAd)) {
                                  throw 'Could not launch';
                                }
                              },
                              child: _showImage(itemIndex))),
                    ),
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          controller.indexImage = index;
                        },
                        autoPlay: true,
                        viewportFraction: 1,
                        height: controller
                            .adsViewModel[controller.indexImage].heightAd
                            .toDouble()),
                  ),
                )

              // child:
            ],
          );
        }),
      ),
    );
  }

  Widget _showImage(int index) {
    if (controller.adsViewModel[index].isShowAd) {
      return Image.network(
        controller.adsViewModel[index].imageAd,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      return SizedBox.fromSize();
    }
  }

  Map arguments({
    required RxList<FactorHomeViewModel> factorHomeList,
  }) {
    final map = {};
    map['factorHomeList'] = factorHomeList;

    return map;
  }
}
