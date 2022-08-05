import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/ads/ads_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/repositories/ads/ads_repository.dart';
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

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadFactorData();
  }

  void saveFactorData() {
    List<String> factorDataList =
        factorHomeList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList(
        factorHomeListSharedPreferencesKey, factorDataList);
  }

  void loadFactorData() {
    isLoading(true);
    List<String> factorDataList =
        sharedPreferences.getStringList(factorHomeListSharedPreferencesKey) ??
            [];
    if (factorDataList.isNotEmpty) {
      factorHomeList.value = factorDataList
          .map((e) => FactorHomeViewModel.fromJson(json.decode(e)))
          .toList();
    }
    factorHomeListSearch.value = factorHomeList;

    isLoading(false);

    // JsonDecoder decoder = const JsonDecoder();
    // String prettyprint = decoder.convert(factorDataList);
    // logger.i(
    //   'factorDataList${jsonDecode(factorDataList)}',
    // );
  }
}
