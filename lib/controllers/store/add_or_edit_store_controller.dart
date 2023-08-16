import 'dart:convert';

import 'package:factor_flutter_mobile/controllers/store/store_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/store/hive/store_item_view_model_hive.dart';

class AddOrEditStoreController extends GetxController {
  final String currencyTitle;

  final storeController = Get.find<StoreController>();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productCountController =
      TextEditingController(text: '1');

  final TextEditingController productUnitPriceController =
      TextEditingController();

  final TextEditingController addUnitPriceController = TextEditingController();




  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Uuid uuid = const Uuid();

  final RxString unitValue = 'عدد'.obs;
  RxList<String> unitList = <String>[
    'افزودن واحد دلخواه +',
    'عدد',
    'کیلوگرم',
    'متر',
  ].obs;

  final Rxn<Box> boxStore ;
  final StoreItemViewModelHive? editingStoreItemItem;
  late final bool isEdit;
  RxBool isLoading = true.obs;

  AddOrEditStoreController(
      StoreItemViewModelHive? item,
    this.boxStore,
    this.sharedPreferences,
    this.currencyTitle,
  )   : editingStoreItemItem = item,
        isEdit = (item != null) {
    if (isEdit) {
      productDescriptionController.text = item!.productDescription;
      productCountController.text = item.productCount.toString();
      productUnitPriceController.text = item.productUnitPrice.replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

      unitValue.value = item.unitValue;
    }
  }

  StoreItemViewModelHive get storeItemDto {
    return StoreItemViewModelHive(
        unitValue: unitValue.value,
        id: uuid.v4(),
        productDescription: productDescriptionController.text,
        productCount: double.tryParse(productCountController.text) ?? 1,
        productUnitPrice:
            productUnitPriceController.text.replaceAll(RegExp(','), ''),
        totalPriceItem: totalPriceItem());
  }

  double totalPriceItem() {
    double _totalPrice = 0;
    String unit =
        productUnitPriceController.value.text.replaceAll(RegExp(','), '');

    _totalPrice += int.parse(unit) * double.parse(productCountController.text) +
        ((double.parse(productCountController.text) *
                double.parse(productUnitPriceController.text
                    .replaceAll(RegExp(','), ''))));

    return _totalPrice;
  }

  void save({int? index}) {
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
      editUnOfficialItem(index!);
      // print(totalPriceItem());
    } else {
      print(storeItemDto.totalPriceItem);
      addUnOfficialItem();
    }
  }

  final SharedPreferences sharedPreferences;



  void addUnOfficialItem() {
    boxStore.value?.add(storeItemDto);
    // saveFactorData();
    storeController.openBoxHive();

    Get.back();
    productDescriptionController.clear();
    productCountController.clear();
    productUnitPriceController.clear();

  }

  void editUnOfficialItem(int index) {

    boxStore.value?.putAt(index ,StoreItemViewModelHive(
    unitValue: unitValue.value,
    id: editingStoreItemItem!.id,
    productDescription: productDescriptionController.text,
    productCount: double.tryParse(productCountController.text) ?? 0,
    productUnitPrice:
    productUnitPriceController.text.replaceAll(RegExp(','), ''),
    totalPriceItem: totalPriceItem(),
    ));
    // saveFactorData();

    storeController.openBoxHive();
    Get.back(result: true);
  }
}
