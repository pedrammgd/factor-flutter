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
  RxList<FactorViewModel> factorList =
      <FactorViewModel>[FactorViewModel(title: 'title', id: 1)].obs;

  late SharedPreferences sharedPreferences;

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadFactorData();
  }

  void saveFactorData() {
    List<String> factorDataList =
        factorList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList('add', factorDataList);
  }

  void loadFactorData() {
    List<String> factorDataList = sharedPreferences.getStringList('add') ?? [];
    factorList.value = factorDataList
        .map((e) => FactorViewModel.fromJson(json.decode(e)))
        .toList();
  }
}
