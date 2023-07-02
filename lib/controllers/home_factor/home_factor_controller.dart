import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/ads/ads_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/hive/factor_view_model_hive.dart';
import 'package:factor_flutter_mobile/repositories/ads/ads_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFactorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    openBoxHive();
  }

  RxBool isLoading = true.obs;

  Rxn<Box> boxFactorHome = Rxn<Box>();

  void openBoxHive() async {
    isLoading(true);

    boxFactorHome.value =
        await Hive.openBox<FactorHomeViewModelHive>('testHome2');
    initSharedPreferences();
  }

  TextEditingController searchTextEditingController = TextEditingController();

  // RxList<FactorHomeViewModel> factorHomeList;
  RxList<FactorHomeViewModel> factorHomeListHive = <FactorHomeViewModel>[].obs;

  // RxList<FactorHomeViewModel> factorHomeListSearch;
  HomeFactorController(// {
      // required this.factorHomeList,
      // required this.factorHomeListSearch,
      // }
      );

  final List<String> popUpItems = <String>[
    Constants.showPopUp,
    Constants.savePopUp,
    Constants.deletePopUp,
    if (!kIsWeb) Constants.printPopUp,
    if (!kIsWeb) Constants.sharePopUp,
  ];

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadFactorData();
  }

  // void saveFactorData() {
  //   List<String> factorDataList =
  //       factorHomeList.map((element) => json.encode(element.toJson())).toList();
  //   sharedPreferences.setStringList(
  //       factorHomeListSharedPreferencesKey, factorDataList);
  // }

  // void deleteFactor(FactorHomeViewModel itemModel) {
  //   factorHomeList.removeWhere((item) => item == itemModel);
  //   List<String> factorDataList =
  //       factorHomeList.map((element) => json.encode(element.toJson())).toList();
  //   sharedPreferences.setStringList(
  //       factorHomeListSharedPreferencesKey, factorDataList);
  // }

  void loadFactorData() {
    List<String> factorDataList =
        sharedPreferences.getStringList(factorHomeListSharedPreferencesKey) ??
            [];
    if (factorDataList.isNotEmpty) {
      // factorHomeList.value=
      factorDataList.map<FactorHomeViewModel>((e) {
        final bool addLastListCon = boxFactorHome.value!.values
            .any((element) => element.id != json.decode(e)['id']);
        if (addLastListCon) {
          boxFactorHome.value?.add(FactorHomeViewModelHive(
              currencyType: json.decode(e)['currencyType'],
              id: json.decode(e)['id'],
              uint8ListPdf: json.decode(e)['uint8ListPdf'],
              titleFactor: json.decode(e)['titleFactor'],
              dateFactor: json.decode(e)['dateFactor'],
              numFactor: json.decode(e)['numFactor'],
              totalPrice: json.decode(e)['totalPrice']));
        }
        // print('jsonDecode${json.decode(e)['totalPrice']}');
        return FactorHomeViewModel.fromJson(json.decode(e));
      }).toList();
    }

    // factorHomeListSearch.value = factorHomeList;

    isLoading(false);

    // JsonDecoder decoder = const JsonDecoder();
    // String prettyprint = decoder.convert(factorDataList);
    // logger.i(
    //   'factorDataList${jsonDecode(factorDataList)}',
    // );
  }
}
