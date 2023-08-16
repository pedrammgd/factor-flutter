import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddOrEditFactorUnofficialController extends GetxController {
  final String currencyTitle;


  @override
  void onInit() {
    super.onInit();
    loadSubscription();
  }


  void loadSubscription() {
    String subscriptionData =
        sharedPreferences.getString(subscriptionSharedPreferencesKey) ?? '';
    if (subscriptionData.isNotEmpty) {
      subscriptionValue.value = subscriptionData;
    }
    // log('loadSubscription${subscriptionData}');
  }
  RxString subscriptionValue = ''.obs;
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productCountController =
      TextEditingController(text: '1');

  final TextEditingController productUnitPriceController =
      TextEditingController();

  final TextEditingController addUnitPriceController = TextEditingController();

  final TextEditingController productDiscountController =
      TextEditingController(text: '0.0');
  final TextEditingController productTaxationController =
      TextEditingController(text: '0.0');

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Uuid uuid = const Uuid();

  final RxString unitValue = 'عدد'.obs;
  RxList<String> unitList = <String>[
    'افزودن واحد دلخواه +',
    'عدد',
    'کیلوگرم',
    'متر',
  ].obs;

  final FactorUnofficialItemViewModel? editingFactorUnofficialItem;
  late final bool isEdit;
  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isLoading = true.obs;

  AddOrEditFactorUnofficialController(
    FactorUnofficialItemViewModel? item,
    this.factorUnofficialItemList,
    this.sharedPreferences,
    this.currencyTitle,
  )   : editingFactorUnofficialItem = item,
        isEdit = (item != null) {
    if (isEdit) {
      productDescriptionController.text = item!.productDescription;
      productCountController.text = item.productCount.toString();
      productUnitPriceController.text = item.productUnitPrice.replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      productDiscountController.text = item.productDiscount.toString();
      productTaxationController.text = item.productTaxation.toString();
      unitValue.value = item.unitValue;
    }
  }



  FactorUnofficialItemViewModel get factorUnofficialItemDto {
    return FactorUnofficialItemViewModel(
        unitValue: unitValue.value,
        id: uuid.v4(),
        productDescription: productDescriptionController.text,
        productCount: double.tryParse(productCountController.text) ?? 1,
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
      FactorSnackBar.getxSnackBar(
          title: 'شرح کالا',
          message: 'فیلد شرح کالا رو فراموش کردی وارد کنی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.description_outlined),
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (productCountController.text.isEmpty) {
      FactorSnackBar.getxSnackBar(
          title: 'واحد',
          message: 'فیلد واحد رو فراموش کردی وارد کنی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.bar_chart_outlined),
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (productUnitPriceController.text.isEmpty) {
      FactorSnackBar.getxSnackBar(
          title: 'قیمت واحد',
          message: 'فیلد قیمت واحد رو فراموش کردی وارد کنی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.attach_money),
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (productDiscountController.text.isEmpty) {
      FactorSnackBar.getxSnackBar(
          title: 'تخفیف',
          message: 'فیلد تخفیف رو فراموش کردی وارد کنی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.discount_outlined),
          snackPosition: SnackPosition.BOTTOM);

      return;
    } else if (productTaxationController.text.isEmpty) {
      FactorSnackBar.getxSnackBar(
          title: 'مالیات',
          message: 'فیلد مالیات رو فراموش کردی وارد کنی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.price_change_outlined),
          snackPosition: SnackPosition.BOTTOM);

      return;
    }
    if (double.parse(productTaxationController.text.trim()) > 100) {
      FactorSnackBar.getxSnackBar(
          title: 'درصد نامعتبر مالیات',
          message: 'درصد مالیات رو نامعتبر وارد کردی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.price_change_outlined),
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (double.parse(productDiscountController.text.trim()) > 100) {
      FactorSnackBar.getxSnackBar(
          title: 'درصد نامعتبر تخفیف',
          message: 'درصد تخفیف رو نامعتبر وارد کردی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.discount_outlined),
          snackPosition: SnackPosition.BOTTOM);

      return;
    }

    if (totalPriceItem() > 999999999999 || totalPriceItem() < 0) {
      FactorSnackBar.getxSnackBar(
          title: 'مبلغ نامعتبر',
          message: 'عدد نامعتبر وارد کردی',
          backgroundColor: redColor,
          iconWidget: const Icon(Icons.numbers),
          snackPosition: SnackPosition.BOTTOM);

      return;
    }
    print(totalPriceItem());

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
      unitValue: unitValue.value,
      id: editingFactorUnofficialItem!.id,
      productDescription: productDescriptionController.text,
      productCount: double.tryParse(productCountController.text) ?? 0,
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
