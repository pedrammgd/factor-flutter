import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddOrEditFactorUnofficialController extends GetxController {
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productCountController =
      TextEditingController(text: '1');

  final TextEditingController productUnitPriceController =
      TextEditingController();

  final TextEditingController productDiscountController =
      TextEditingController(text: '0.0');
  final TextEditingController productTaxationController =
      TextEditingController(text: '0.0');

  // GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Uuid uuid = const Uuid();

  final FactorUnofficialItemViewModel? editingFactorUnofficialItem;
  late final bool isEdit;
  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isLoading = true.obs;

  AddOrEditFactorUnofficialController(
    FactorUnofficialItemViewModel? item,
    this.factorUnofficialItemList,
    this.sharedPreferences,
  )   : editingFactorUnofficialItem = item,
        isEdit = (item != null) {
    if (isEdit) {
      productDescriptionController.text = item!.productDescription;
      productCountController.text = item.productCount.toString();
      productUnitPriceController.text = item.productUnitPrice.replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      productDiscountController.text = item.productDiscount.toString();
      productTaxationController.text = item.productTaxation.toString();
    }
  }

  FactorUnofficialItemViewModel get factorUnofficialItemDto {
    return FactorUnofficialItemViewModel(
        id: uuid.v4(),
        productDescription: productDescriptionController.text,
        productCount: int.tryParse(productCountController.text) ?? 1,
        productUnitPrice:
            productUnitPriceController.text.replaceAll(RegExp(','), ''),
        productDiscount: double.tryParse(productDiscountController.text) ?? 0,
        productTaxation: double.tryParse(productTaxationController.text) ?? 0,
        totalPriceItem: totalPriceItem());
  }

  double totalPriceItem() {
    double _totalPrice = 0;
    String unit =
        productUnitPriceController.value.text.replaceAll(RegExp(','), '');

    _totalPrice += int.parse(unit) * double.parse(productCountController.text) +
        ((double.parse(productCountController.text) *
                double.parse(productUnitPriceController.text
                    .replaceAll(RegExp(','), '')) *
                double.parse(productTaxationController.text)) /
            100) -
        ((double.parse(productCountController.text) *
                double.parse(productUnitPriceController.text
                    .replaceAll(RegExp(','), '')) *
                double.parse(productDiscountController.text)) /
            100);

    return _totalPrice;
  }

  void save() {
    // if (!formKey.currentState!.validate()) return;
    if (productDescriptionController.text.isEmpty) {
      Get.snackbar('فیلد خالی', 'فیلد شرح کالا رو فراموش کردی وارد کنی',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (productCountController.text.isEmpty) {
      Get.snackbar('فیلد خالی', 'فیلد تعداد رو فراموش کردی وارد کنی',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (productUnitPriceController.text.isEmpty) {
      Get.snackbar('فیلد خالی', 'فیلد قیمت واحد رو فراموش کردی وارد کنی',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (productDiscountController.text.isEmpty) {
      Get.snackbar('فیلد خالی', 'فیلد تخفیف رو فراموش کردی وارد کنی',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (productTaxationController.text.isEmpty) {
      Get.snackbar('فیلد خالی', 'فیلد مالیات رو فراموش کردی وارد کنی',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (double.parse(productTaxationController.text.trim()) > 100) {
      Get.snackbar('درصد نامعتبر', 'درصد مالیات رو نامعتبر وارد کردی',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (double.parse(productDiscountController.text.trim()) > 100) {
      Get.snackbar('درصد نامعتبر', 'درصد تخفیف رو نامعتبر وارد کردی',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (isEdit) {
      editUnOfficialItem();
      // print(totalPriceItem());
    } else {
      print(factorUnofficialItemDto.totalPriceItem);
      addUnOfficialItem();
    }
  }

  final SharedPreferences sharedPreferences;

  void saveFactorData() {
    List<String> factorDataList = factorUnofficialItemList
        .map((element) => json.encode(element.toJson()))
        .toList();
    sharedPreferences.setStringList(
        unofficialFactorSharedPreferencesKey, factorDataList);
  }

  void addUnOfficialItem() {
    factorUnofficialItemList.add(factorUnofficialItemDto);
    // saveFactorData();
    Get.back();
    productDescriptionController.clear();
    productCountController.clear();
    productUnitPriceController.clear();
    productDiscountController.clear();
    productTaxationController.clear();
  }

  void editUnOfficialItem() {
    int index = factorUnofficialItemList
        .indexWhere((element) => element.id == editingFactorUnofficialItem?.id);

    factorUnofficialItemList[index] = FactorUnofficialItemViewModel(
      id: editingFactorUnofficialItem!.id,
      productDescription: productDescriptionController.text,
      productCount: int.tryParse(productCountController.text) ?? 0,
      productUnitPrice:
          productUnitPriceController.text.replaceAll(RegExp(','), ''),
      productDiscount: double.tryParse(productDiscountController.text) ?? 0,
      productTaxation: double.tryParse(productTaxationController.text) ?? 0,
      totalPriceItem: totalPriceItem(),
    );
    // saveFactorData();

    Get.back(result: true);
  }
}
