import 'dart:convert';
import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/models/sheard/person_basic_information_view_model.dart/person_basic_information_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class BuyerAddOrEditController extends GetxController {
  BuyerAddOrEditController(BuyerViewModel? item,
      {required this.buyerList, required this.sharedPreferences})
      : editBuyerViewModel = item,
        isEdit = (item != null) {
    if (isEdit) {
      mobileTextEditingController.text =
          item!.personBasicInformationViewModel.mobileNumber ?? '';
      fullNameTextEditingController.text =
          item.personBasicInformationViewModel.fullName ?? '';
      nationalCodeTextEditingController.text =
          item.personBasicInformationViewModel.nationalCode ?? '';
      mobileTextHoghoghiEditingController.text =
          item.personBasicInformationViewModel.mobileNumberHoghoghi ?? '';
      nationalCodeCompanyTextEditingController.text =
          item.personBasicInformationViewModel.nationalCodeCompany ?? '';
      companyNameTextEditingController.text =
          item.personBasicInformationViewModel.companyName ?? '';
      addressTextEditingController.text =
          item.personBasicInformationViewModel.address ?? '';
      isHaghighi.value = item.personBasicInformationViewModel.isHaghighi;
      addressTextHoghohgiEditingController.text =
          item.personBasicInformationViewModel.addressHoghoghi ?? '';
    }
  }

  RxBool isHaghighi = true.obs;
  RxBool isLoadingButton = false.obs;
  RxBool isShowSnackBar = false.obs;
  RxList<BuyerViewModel> buyerList;
  final BuyerViewModel? editBuyerViewModel;
  late final bool isEdit;

  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController mobileTextHoghoghiEditingController =
      TextEditingController();
  TextEditingController fullNameTextEditingController = TextEditingController();

  TextEditingController nationalCodeTextEditingController =
      TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController addressTextHoghohgiEditingController =
      TextEditingController();
  TextEditingController companyNameTextEditingController =
      TextEditingController();
  TextEditingController nationalCodeCompanyTextEditingController =
      TextEditingController();

  GlobalKey<FormState> haghighiFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hoghoghiFormKey = GlobalKey<FormState>();

  final Uuid uuid = const Uuid();

  final SharedPreferences sharedPreferences;

  void save() {
    if (isEdit) {
      if (isHaghighi.value) {
        if (!haghighiFormKey.currentState!.validate()) {
          _snackBarError();

          return;
        }
        editUnOfficialItem();
        Get.back(result: true);
        _snackBarSuccess(
            isHaghighi: true,
            message: 'ویرایش',
            title: 'ویرایش ${fullNameTextEditingController.text}');
      } else {
        if (!hoghoghiFormKey.currentState!.validate()) {
          _snackBarError();
          return;
        }
        editUnOfficialItem();
        Get.back(result: true);
        _snackBarSuccess(
          isHaghighi: false,
          title: 'ویرایش ${companyNameTextEditingController.text}',
          message: 'ویرایش',
        );
      }
    } else {
      if (isHaghighi.value) {
        if (!haghighiFormKey.currentState!.validate()) {
          _snackBarError();
          return;
        }
        addToBuyerHaghighiList();
        Get.back(result: true);
        _snackBarSuccess(
          isHaghighi: true,
          title: 'ثبت ${fullNameTextEditingController.text}',
          message: 'ثبت',
        );
      } else {
        if (!hoghoghiFormKey.currentState!.validate()) {
          _snackBarError();
          return;
        }
        addToBuyerHoghoghiList();
        Get.back(result: true);
        _snackBarSuccess(
          isHaghighi: false,
          title: 'ثبت ${companyNameTextEditingController.text}',
          message: 'ثبت',
        );
      }
    }

    // Get.back(result: true);
    // _snackBarSuccess(title: 'ثبت مشتری');
  }

  void buttonTimerLoading() {
    isLoadingButton(true);
    Future.delayed(const Duration(milliseconds: 4000), () {
      isLoadingButton(false);
    });
  }

  void _snackBarSuccess(
      {required String title,
      required String message,
      required bool isHaghighi}) {
    FactorSnackBar.getxSnackBar(
        title: title,
        message: '$message مشتری با موفقیت انجام شد ',
        iconWidget: isHaghighi
            ? const Icon(Icons.person_outline)
            : const Icon(Icons.apartment));
    buttonTimerLoading();
  }

  void _snackBarError() {
    FactorSnackBar.getxSnackBar(
        title: 'مشکلی پیش اومده',
        message: 'انگار بعضی از فیلد ها رو تکمیل نکردی یا اشتباه وارد کردی',
        iconWidget: const Icon(Icons.error_outline),
        backgroundColor: Colors.red);
    buttonTimerLoading();
  }

  BuyerViewModel get _haghighiDto {
    return BuyerViewModel(
        personBasicInformationViewModel: PersonBasicInformationViewModel(
            id: uuid.v4(),
            address: addressTextEditingController.text.isEmpty
                ? ''
                : addressTextEditingController.text,
            mobileNumber: mobileTextEditingController.text.isEmpty
                ? ''
                : mobileTextEditingController.text,
            isHaghighi: isHaghighi.value,
            fullName: fullNameTextEditingController.text.isEmpty
                ? ''
                : fullNameTextEditingController.text,
            nationalCode: nationalCodeTextEditingController.text.isEmpty
                ? ''
                : nationalCodeTextEditingController.text));
  }

  BuyerViewModel get _hoghoghiDto {
    return BuyerViewModel(
        personBasicInformationViewModel: PersonBasicInformationViewModel(
      id: uuid.v4(),
      addressHoghoghi: addressTextEditingController.text.isEmpty
          ? ''
          : addressTextEditingController.text,
      mobileNumberHoghoghi: mobileTextHoghoghiEditingController.text.isEmpty
          ? ''
          : mobileTextHoghoghiEditingController.text,
      isHaghighi: isHaghighi.value,
      companyName: companyNameTextEditingController.text.isEmpty
          ? ''
          : companyNameTextEditingController.text,
      nationalCodeCompany: nationalCodeCompanyTextEditingController.text.isEmpty
          ? ''
          : nationalCodeCompanyTextEditingController.text,
    ));
  }

  void saveData() {
    List<String> buyerData =
        buyerList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList(buyerSharedPreferencesKey, buyerData);

    log('$buyerData');
  }

  void addToBuyerHaghighiList() {
    buyerList.add(_haghighiDto);
    saveData();
  }

  void addToBuyerHoghoghiList() {
    buyerList.add(_hoghoghiDto);

    saveData();
  }

  void editUnOfficialItem() {
    int index = buyerList.indexWhere((element) =>
        element.personBasicInformationViewModel.id ==
        editBuyerViewModel?.personBasicInformationViewModel.id);

    if (isHaghighi.value) {
      buyerList[index] = _haghighiDto;
    } else {
      buyerList[index] = _hoghoghiDto;
    }
    saveData();
  }
}
