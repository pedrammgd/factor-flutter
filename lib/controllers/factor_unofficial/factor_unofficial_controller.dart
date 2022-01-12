import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorUnofficialController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxBool isLoading = false.obs;

  RxList<FactorUnofficialItemViewModel> factorUnofficialItemList =
      <FactorUnofficialItemViewModel>[].obs;



  final List<String> popUpItems = <String>[Constants.editPopUp, Constants.removePopUp];


  late SharedPreferences sharedPreferences;

  initSharedPreferences() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();
      loadFactorData();
      isLoading.value = false;
    });
  }

  void loadFactorData() {
    List<String> factorUnofficialDataList =
        sharedPreferences.getStringList(unofficialFactorSharedPreferencesKey) ?? [];
    factorUnofficialItemList.value = factorUnofficialDataList
        .map((e) => FactorUnofficialItemViewModel.fromJson(json.decode(e)))
        .toList();
  }

  void saveFactorData() {
    List<String> factorDataList = factorUnofficialItemList
        .map((element) => json.encode(element.toJson()))
        .toList();
    sharedPreferences.setStringList(unofficialFactorSharedPreferencesKey, factorDataList);
  }


  void removeItem(FactorUnofficialItemViewModel item) {
    factorUnofficialItemList.remove(item);
  }
}
