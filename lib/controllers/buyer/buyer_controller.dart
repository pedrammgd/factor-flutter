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

  BuyerController({required this.isEnterFromSpecificFactor});

  TextEditingController searchTextEditingController = TextEditingController();
  late SharedPreferences sharedPreferences;
  RxList<BuyerViewModel> buyerList = <BuyerViewModel>[].obs;

  RxList<BuyerViewModel> buyerListSearch = <BuyerViewModel>[].obs;

  final bool isEnterFromSpecificFactor;

  RxBool isShowFoundSearch = false.obs;

  void searchBuyer(String value) {
    if (value.isEmpty) {
      isShowFoundSearch.value = false;
    } else {
      isShowFoundSearch.value = true;
    }
    buyerListSearch.value = buyerList.where((element) {
      final name = element.personBasicInformationViewModel.fullName
              ?.toLowerCase() ??
          element.personBasicInformationViewModel.companyName?.toLowerCase();

      print(name);
      return name!.contains(value.toLowerCase());
    }).toList();
  }

  final List<String> popUpItems = <String>[
    Constants.editPopUp,
    Constants.removePopUp
  ];

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadBuyerData();
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
    loadBuyerData();
  }

  Future<void> removeItem(BuyerViewModel item) async {
    buyerListSearch.remove(item);
    buyerList.remove(item);
    searchTextEditingController.clear();
    isShowFoundSearch.value = false;
    saveData();
  }
}
