import 'dart:convert';
import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFactorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  TextEditingController searchTextEditingController = TextEditingController();
  RxBool isLoading = false.obs;

  RxList<FactorHomeViewModel> factorHomeList;
  RxList<FactorHomeViewModel> factorHomeListSearch;
  HomeFactorController({
    required this.factorHomeList,
    required this.factorHomeListSearch,
  });

  final List<String> popUpItems = <String>[
    Constants.showPopUp,
    Constants.savePopUp,
    if (!kIsWeb) Constants.printPopUp,
    if (!kIsWeb) Constants.sharePopUp,
  ];

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
    if (factorDataList.isNotEmpty) {
      factorHomeList.value = factorDataList
          .map((e) => FactorHomeViewModel.fromJson(json.decode(e)))
          .toList();
    }
    factorHomeListSearch.value = factorHomeList;

    log('factorDataList${factorDataList}');
  }
}
