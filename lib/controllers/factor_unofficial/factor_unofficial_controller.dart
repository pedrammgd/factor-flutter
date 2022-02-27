import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/factor_unofficial_specification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/src/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorUnofficialController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();

    scrollController.addListener(() {
      offsetScroll.value = scrollController.offset;
      if (offsetScroll.value > 10) {
        isExpandedBottomSheet(false);
      }
    });
  }

  final ScrollController scrollController = ScrollController();
  RxDouble offsetScroll = 0.0.obs;

  RxBool isLoading = false.obs;
  RxBool isExpandedBottomSheet = false.obs;

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

  RxDouble totalPrice() {
    RxDouble _totalPrice = 0.0.obs;

    _totalPrice.value = price() + taxation() - discount();

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

  void bottomSheetButtonOnTap() {
    if (totalPrice() > 999999999999 ||
        taxation() > 999999999999 ||
        discount() > 999999999999) {
      Get.snackbar('قیمت نامعتبر',
          'فکر کنم قیمت رو بیشتر از حد مجاز وارد کردی ، دوباره قیمت ها رو نگاه کن ، حداکثر مبلغ مجاز 999,999,999,999');
      return;
    }
    if (factorUnofficialItemList.isEmpty) return;

    Get.toNamed(FactorRoutes.factorUnofficialSpecification,
        arguments: FactorUnofficialSpecificationPage().arguments(
            factorUnofficialItemList: factorUnofficialItemList,
            totalPrice: totalPrice(),
            totalWordPrice: '${totalPrice().value}'.toWord(),
            taxation: taxation().toStringAsFixed(2).seRagham() + ' ریال',
            discount: discount().toStringAsFixed(2).seRagham() + ' ریال'));

    isExpandedBottomSheet.value = !isExpandedBottomSheet.value;
  }
}
