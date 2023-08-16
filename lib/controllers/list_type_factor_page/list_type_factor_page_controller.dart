import 'dart:developer';

import 'package:factor_flutter_mobile/controllers/factor_base/factor_base_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/ads/ads_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/hive/factor_view_model_hive.dart';
import 'package:factor_flutter_mobile/repositories/ads/ads_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListTypeFactorPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (isLoadingAd.value == true) {
      Get.find<FactorBaseController>().loadAds();
    }
    initSharedPreferences();
  }


  ListTypeFactorPageController({
    required this.adsViewModel,
    required this.isLoadingAd,
  });

  final RxList<AdsViewModel> adsViewModel;

  final RxBool isLoadingAd;
  RxBool isShowAd = false.obs;
  RxBool isErrorAd = false.obs;
  int indexImage = 0;

  // Future<void> loadAds() async {
  //   isLoadingAd(true);
  //
  //   var resultOrException = await _repository.getAds();
  //   resultOrException.fold((exception) {
  //     isErrorAd(true);
  //     log('eeeerrrr${exception}');
  //   }, (List<AdsViewModel> r) {
  //     adsViewModel(r);
  //     print(r);
  //     isLoadingAd(false);
  //   });
  // }

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    loadSubscription();
  }

  RxString subscriptionValue = ''.obs;

  void loadSubscription() {
    String subscriptionData =
        sharedPreferences.getString(subscriptionSharedPreferencesKey) ?? '';
    if (subscriptionData.isNotEmpty) {
      subscriptionValue.value = subscriptionData;

      if (subscriptionData == 'gold') {
        isShowAd(false);
      } else {
        isShowAd(true);
      }
    } else {
      isShowAd(true);
    }
    // log('loadSubscription${subscriptionData}');
  }
}
