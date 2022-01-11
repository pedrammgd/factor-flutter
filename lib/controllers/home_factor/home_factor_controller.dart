import 'dart:convert';

import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFactorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxBool isLoading = false.obs;
  RxList<FactorViewModel> factorList = <FactorViewModel>[].obs;

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
        factorList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList('addToFactorList', factorDataList);
  }

  void loadFactorData() {
    List<String> factorDataList = sharedPreferences.getStringList('addToFactorList') ?? [];
    factorList.value = factorDataList
        .map((e) => FactorViewModel.fromJson(json.decode(e)))
        .toList();
  }
}
