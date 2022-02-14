import 'dart:convert';
import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  TextEditingController searchTextEditingController = TextEditingController();
  late SharedPreferences sharedPreferences;
  RxBool isLoading = false.obs;
  RxList<BuyerViewModel> buyerList = <BuyerViewModel>[].obs;

  RxList<BuyerViewModel> buyerListSearch = <BuyerViewModel>[].obs;

  void searchBuyer(String value) {
    buyerListSearch.value = buyerList.where((element) {
      final name = element.personBasicInformationViewModel.firstName ?? '';
      print(name);
      return name.contains(value);
    }).toList();
  }

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

  Future loadBuyerData() async {
    List<String> buyerDataList =
        sharedPreferences.getStringList(buyerSharedPreferencesKey) ?? [];
    buyerList.value = buyerDataList
        .map((e) => BuyerViewModel.fromJson(json.decode(e)))
        .toList();
    buyerListSearch.value = buyerList;
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
