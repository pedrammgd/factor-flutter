import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFactorController extends GetxController {
  @override
  void onInit() {
    print('home');
    super.onInit();
    initSharedPreferences();
  }

  RxBool isLoading = false.obs;
  RxList<FactorHomeViewModel> factorHomeList;

  HomeFactorController({required this.factorHomeList});

  late SharedPreferences sharedPreferences;

  initSharedPreferences() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();
      loadFactorData();
      isLoading.value = false;
    });
  }

  void saveFactorData() {
    List<String> factorDataList =
        factorHomeList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList(
        factorHomeListSharedPreferencesKey, factorDataList);
  }

  void loadFactorData() {
    List<String> factorDataList =
        sharedPreferences.getStringList(factorHomeListSharedPreferencesKey) ??
            [];
    factorHomeList.value = factorDataList
        .map((e) => FactorHomeViewModel.fromJson(json.decode(e)))
        .toList();

    print('factorDataList${factorDataList}');
  }
}
