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

  final List<String> popUpItems = <String>[
    Constants.editPopUp,
    Constants.removePopUp
  ];
  initSharedPreferences() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();
      loadBuyerData();
      isLoading.value = false;
    });
  }

  void loadBuyerData() {
    List<String> buyerDataList =
        sharedPreferences.getStringList(buyerSharedPreferencesKey) ?? [];
    buyerList.value = buyerDataList
        .map((e) => BuyerViewModel.fromJson(json.decode(e)))
        .toList();
    log('$buyerDataList');
  }

  void saveData() {
    List<String> buyerData =
        buyerList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList(buyerSharedPreferencesKey, buyerData);
  }

  void removeItem(BuyerViewModel item) {
    buyerList.remove(item);
    saveData();
  }
}
