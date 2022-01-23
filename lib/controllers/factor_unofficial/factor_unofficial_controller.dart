import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorUnofficialController extends GetxController {
  FactorUnofficialController({required this.isBeforeFactor});

  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxBool isLoading = false.obs;
  RxBool isExpandedBottomSheet = false.obs;
  final bool isBeforeFactor;

  RxList<FactorUnofficialItemViewModel> factorUnofficialItemList =
      <FactorUnofficialItemViewModel>[].obs;

  final List<String> popUpItems = <String>[
    Constants.editPopUp,
    Constants.removePopUp
  ];

  int price() {
    int _price = 0;
    for (var element in factorUnofficialItemList) {
      _price += int.parse(element.productUnitPrice) * element.productCount;
    }
    return _price;
  }

  double taxation() {
    double _taxation = 0;
    for (var element in factorUnofficialItemList) {
      _taxation += ((element.productCount *
              int.parse(element.productUnitPrice) *
              element.productTaxation) /
          100);
    }
    return _taxation;
  }

  double discount() {
    double _discount = 0;
    for (var element in factorUnofficialItemList) {
      _discount += (element.productCount *
              int.parse(element.productUnitPrice) *
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

  double totalPriceItem(FactorUnofficialItemViewModel item) {
    double _totalPrice = 0;

    _totalPrice += (int.parse(item.productUnitPrice) * item.productCount) +
        ((item.productCount *
                int.parse(item.productUnitPrice) *
                item.productTaxation) /
            100) -
        (item.productCount *
                int.parse(item.productUnitPrice) *
                item.productDiscount) /
            100;

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
        sharedPreferences.getStringList(unofficialFactorSharedPreferencesKey) ??
            [];
    factorUnofficialItemList.value = factorUnofficialDataList
        .map((e) => FactorUnofficialItemViewModel.fromJson(json.decode(e)))
        .toList();
  }

  void saveFactorData() {
    List<String> factorDataList = factorUnofficialItemList
        .map((element) => json.encode(element.toJson()))
        .toList();
    sharedPreferences.setStringList(
        unofficialFactorSharedPreferencesKey, factorDataList);
  }

  void removeItem(FactorUnofficialItemViewModel item) {
    factorUnofficialItemList.remove(item);
  }
}
