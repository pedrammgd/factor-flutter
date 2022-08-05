import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:factor_flutter_mobile/controllers/list_type_factor_page/list_type_factor_page_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/ads/ads_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/factor_unofficial_page.dart';
import 'package:factor_flutter_mobile/views/shared/factor_circular_progress_indicator.dart';
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
    final adsViewModel = arguments['adsViewModel'];
    final isLoadingAd = arguments['isLoadingAd'];

    Get.put<ListTypeFactorPageController>(ListTypeFactorPageController(
        factorHomeList: factorHomeList,
        adsViewModel: adsViewModel,
        isLoadingAd: isLoadingAd));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return Scaffold(
      appBar: FactorAppBar(
          title: Padding(
        padding: const EdgeInsets.only(top: 23),
        child: Text(
          'افزودن فاکتور',
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ),
      )),
      body: Center(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Center(
                  child:
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 13,
                    spacing: 10,
                    children: [
                      Constants.veryTinyHorizontalSpacer,
                      FadeInRightBig(
                        child: CardIconWidget(
                          onTap: () {
                            Get.toNamed(FactorRoutes.factorUnofficial,
                                arguments: FactorUnofficialPage().arguments(
                                    factorHomeList: controller.factorHomeList));
                          },
                          title: 'فاکتور غیر رسمی',
                          icon: addFactorUnOfficialIcon,
                          infoOnTap: () {
                            Get.defaultDialog(
                                title: 'فاکتور غیر رسمی',
                                middleText:
                                    'شامل فاکتور فروش ، فاکتور خرید ، فاکتور خدمات، فاکتور فروشگاهی و...... می باشد',
                                textCancel: 'فهمیدم');
                          },
                        ),
                      ),
                      FadeInLeftBig(
                        child: CardIconWidget(
                            comingSoon: true,
                            onTap: () {},
                            title: 'انبار',
                            icon: warehouseIcon),
                      ),
                      FadeInUpBig(
                        child: CardIconWidget(
                            comingSoon: true,
                            iconColor: Colors.grey,
                            onTap: () {},
                            title: 'فاکتور رسمی',
                            icon: addFactorOfficialIcon),
                      ),
                    ],
                  ),
                  //   ],
                  // ),
                ),
              ),

              Align(alignment: Alignment.bottomCenter, child: _adsItemWidget()),

              // child:
            ],
          );
        }),
      ),
    );
  }

  Widget _adsItemWidget() {
    if (controller.isLoadingAd.value) {
      return _loadingAdWidget();
    } else {
      if (controller.isShowAd.value) {
        return FadeInUp(
          child: CarouselSlider.builder(
            itemCount: controller.adsViewModel.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                      onTap: () async {
                        if (controller.adsViewModel[itemIndex].isShowAd) {
                          if (!await launch(
                              controller.adsViewModel[itemIndex].linkAd)) {
                            throw 'Could not launch';
                          }
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
                height: controller.adsViewModel[controller.indexImage].heightAd
                        ?.toDouble() ??
                    80),
          ),
        );
      }
      return const SizedBox();
    }
  }

  Widget _loadingAdWidget() {
    return FadeInUp(
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              adsIconImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

  Widget _showImage(int index) {
    if (controller.adsViewModel[index].isShowAd) {
      return CachedNetworkImage(
        imageUrl: controller.adsViewModel[index].imageAd,
        placeholder: (context, url) => const Center(
            child: SizedBox(
                width: 15, height: 15, child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
        width: double.infinity,
      );

      // return Image.network(
      //   controller.adsViewModel[index].imageAd,
      //   fit: BoxFit.cover,
      //   width: double.infinity,
      //   errorBuilder:
      //       (BuildContext context, Object exception, StackTrace? stackTrace) {
      //     return Image.asset(
      //       adsIconImage,
      //       fit: BoxFit.cover,
      //       width: double.infinity,
      //     );
      //   },
      // );
    } else {
      return Image.asset(
        adsIconImage,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
  }

  Map arguments({
    required RxList<FactorHomeViewModel> factorHomeList,
    required RxList<AdsViewModel> adsViewModel,
    required RxBool isLoadingAd,
  }) {
    final map = {};
    map['factorHomeList'] = factorHomeList;
    map['adsViewModel'] = adsViewModel;
    map['isLoadingAd'] = isLoadingAd;

    return map;
  }
}
