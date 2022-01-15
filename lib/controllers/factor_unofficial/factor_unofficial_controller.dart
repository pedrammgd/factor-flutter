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

    print(factorUnofficialItemList);
  }

  RxBool isLoading = false.obs;

  int a = 0;

  RxList<FactorUnofficialItemViewModel> factorUnofficialItemList =
      <FactorUnofficialItemViewModel>[].obs;

  final List<String> popUpItems = <String>[
    Constants.editPopUp,
    Constants.removePopUp
  ];

  int price() {
    int _price = 0;
    for (var element in factorUnofficialItemList) {
      _price += element.productUnitPrice * element.productCount;
    }
    return _price;
  }

  double taxation() {
    double _taxation = 0;
    for (var element in factorUnofficialItemList) {
      _taxation += (element.productCount *
              element.productUnitPrice *
              element.productTaxation) /
          100;
    }
    return _taxation;
  }

  double discount() {
    double _discount = 0;
    for (var element in factorUnofficialItemList) {
      _discount += (element.productCount *
              element.productUnitPrice *
              element.productDiscount) /
          100;
    }
    return _discount;
  }

  double totalPrice() {
    double _totalPrice = 0;

    _totalPrice = price() + taxation() - discount();

    return _totalPrice;
  }

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
