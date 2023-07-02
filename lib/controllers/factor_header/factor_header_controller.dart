import 'dart:convert';

import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_header/factor_header_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorHeaderController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
    factorNumTextEditingController.text =
        '${factorHomeController.factorHomeListHive.length + 1}';
  }

  RxString dateSelected = Jalali.now().formatCompactDate().obs;
  RxBool isBeforeFactor = false.obs;
  final HomeFactorController factorHomeController =
      Get.find<HomeFactorController>();

  FocusNode focusNode = FocusNode();

  TextEditingController factorTitleTextEditingController =
      TextEditingController(text: 'فاکتور فروش');
  TextEditingController factorNumTextEditingController =
      TextEditingController();
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

  void save() {
    if (!formKey.currentState!.validate()) {
      _snackBarError();
      return;
    }
    saveFactorHeaderData();
    Get.back(result: factorHeaderViewModel);
    _snackBarSuccess();
  }

  void _snackBarError() {
    FactorSnackBar.getxSnackBar(
        title: 'مشکلی پیش اومده',
        message: 'انگار بعضی از فیلد ها رو تکمیل نکردی یا اشتباه وارد کردی',
        iconWidget: const Icon(Icons.error_outline),
        backgroundColor: Colors.red);
  }

  void _snackBarSuccess() {
    FactorSnackBar.getxSnackBar(
        title: 'ثبت سربرگ فاکتور',
        message: 'سربرگ فاکتور با موفقیت ویرایش شد',
        icon: documentHeaderIcon);
  }
}
