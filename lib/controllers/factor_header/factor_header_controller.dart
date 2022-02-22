import 'dart:convert';
import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_header/factor_header_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorHeaderController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxString dateSelected = Jalali.now().formatCompactDate().obs;
  RxBool isBeforeFactor = false.obs;

  TextEditingController factorTitleTextEditingController =
      TextEditingController(text: 'فاکتور فروش');
  TextEditingController factorNumTextEditingController =
      TextEditingController(text: '1');
  TextEditingController beForeFactorDurationTextEditingController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rxn<FactorHeaderViewModel> factorHeaderViewModel =
      Rxn<FactorHeaderViewModel>();

  FactorHeaderViewModel get _dtoFactorHeader {
    return FactorHeaderViewModel(
        title: factorTitleTextEditingController.text,
        factorNum: factorNumTextEditingController.text,
        factorDate: dateSelected.value,
        isBeforeFactor: isBeforeFactor.value,
        durationBeforeFactor: beForeFactorDurationTextEditingController.text);
  }

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    loadFactorHeaderData();
  }

  void loadFactorHeaderData() {
    String factorHeaderData =
        sharedPreferences.getString(factorHeaderSharedPreferencesKey) ?? '';

    if (factorHeaderData.isNotEmpty) {
      factorHeaderViewModel.value =
          FactorHeaderViewModel.fromJson(jsonDecode(factorHeaderData));
      log(factorHeaderData);
      loadFactorHeaderReplaceItem();
    }
  }

  void loadFactorHeaderReplaceItem() {
    factorTitleTextEditingController.text =
        factorHeaderViewModel.value?.title ?? '';
    factorNumTextEditingController.text =
        factorHeaderViewModel.value?.factorNum ?? '';
    beForeFactorDurationTextEditingController.text =
        factorHeaderViewModel.value?.durationBeforeFactor ?? '';
    dateSelected.value = factorHeaderViewModel.value!.factorDate;
    isBeforeFactor.value = factorHeaderViewModel.value!.isBeforeFactor;
  }

  void saveFactorHeaderData() {
    String factorHeaderData = json.encode(_dtoFactorHeader.toJson());
    sharedPreferences.setString(
        factorHeaderSharedPreferencesKey, factorHeaderData);
  }

  void saveFactorHeader() {
    saveFactorHeaderData();
  }

  void save() {
    if (!formKey.currentState!.validate()) return;
    saveFactorHeaderData();
    Get.back(result: factorHeaderViewModel);
  }
}
