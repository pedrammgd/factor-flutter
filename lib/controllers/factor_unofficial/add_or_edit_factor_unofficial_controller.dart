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
      TextEditingController(text: '0');
  final TextEditingController productTaxationController =
      TextEditingController(text: '0');

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Uuid uuid = const Uuid();

  final FactorUnofficialItemViewModel? editingFactorUnofficialItem;
  late final bool isEdit;
  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isLoading = true.obs;

  AddOrEditFactorUnofficialController(FactorUnofficialItemViewModel? item,
      this.factorUnofficialItemList, this.sharedPreferences)
      : editingFactorUnofficialItem = item,
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
    );
  }

  void save() {
    if (!formKey.currentState!.validate()) return;
    if (isEdit) {
      editUnOfficialItem();
    } else {
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
    );
    // saveFactorData();

    Get.back(result: true);
  }
}
