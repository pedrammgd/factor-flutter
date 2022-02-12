import 'dart:convert';
import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  late SharedPreferences sharedPreferences;
  RxBool isLoading = false.obs;
  RxList<BuyerViewModel> buyerList = <BuyerViewModel>[].obs;

  initSharedPreferences() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();
      loadHaghighiBuyerData();
      // loadHoghoghiBuyerData();
      isLoading.value = false;
    });
  }

  void loadHaghighiBuyerData() {
    List<String> haghighiBuyerDataList =
        sharedPreferences.getStringList(haghighiBuyerSharedPreferencesKey) ??
            [];
    buyerList.value = haghighiBuyerDataList
        .map((e) => BuyerViewModel.fromJson(json.decode(e)))
        .toList();
    log('$haghighiBuyerDataList');
  }

  void loadHoghoghiBuyerData() {
    List<String> hoghoghiBuyerDataList =
        sharedPreferences.getStringList(hoghoghiBuyerSharedPreferencesKey) ??
            [];
    buyerList.value = hoghoghiBuyerDataList
        .map((e) => BuyerViewModel.fromJson(json.decode(e)))
        .toList();
    log('$hoghoghiBuyerDataList');
  }
}
