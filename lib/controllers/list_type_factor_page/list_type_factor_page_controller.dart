import 'dart:developer';

import 'package:factor_flutter_mobile/models/ads/ads_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/repositories/ads/ads_repository.dart';
import 'package:get/get.dart';

class ListTypeFactorPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadAds();
  }

  final RxList<FactorHomeViewModel> factorHomeList;

  ListTypeFactorPageController({required this.factorHomeList});

  RxList<AdsViewModel> adsViewModel = RxList<AdsViewModel>();

  final AdsRepository _repository = AdsRepository();
  RxBool isLoadingAd = false.obs;
  RxBool isErrorAd = false.obs;
  int indexImage = 0;

  Future<void> loadAds() async {
    isLoadingAd(true);

    var resultOrException = await _repository.getAds();
    resultOrException.fold((exception) {
      isErrorAd(true);
      log('exception${exception}');
    }, (List<AdsViewModel> r) {
      adsViewModel(r);
      print(r);
      isLoadingAd(false);
    });
  }
}
