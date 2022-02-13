import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/models/sheard/person_basic_information_view_model.dart/person_basic_information_view_model.dart';
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
      firstNameTextEditingController.text =
          item.personBasicInformationViewModel.firstName ?? '';
      lastNameTextEditingController.text =
          item.personBasicInformationViewModel.lastName ?? '';
      nationalCodeTextEditingController.text =
          item.personBasicInformationViewModel.nationalCode ?? '';
      mobileTextHoghoghiEditingController.text =
          item.personBasicInformationViewModel.mobileNumberHoghoghi ?? '';
      registrationIDTextEditingController.text =
          item.personBasicInformationViewModel.registrationID ?? '';
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
  RxList<BuyerViewModel> buyerList;
  final BuyerViewModel? editBuyerViewModel;
  late final bool isEdit;
  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController mobileTextHoghoghiEditingController =
      TextEditingController();
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController nationalCodeTextEditingController =
      TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController addressTextHoghohgiEditingController =
      TextEditingController();
  TextEditingController companyNameTextEditingController =
      TextEditingController();
  TextEditingController nationalCodeCompanyTextEditingController =
      TextEditingController();
  TextEditingController registrationIDTextEditingController =
      TextEditingController();

  final Uuid uuid = const Uuid();

  final SharedPreferences sharedPreferences;

  void save() {
    if (isEdit) {
      editUnOfficialItem();
    } else {
      if (isHaghighi.value) {
        addToBuyerHaghighiList();
      } else {
        addToBuyerHoghoghiList();
      }
    }
    Get.back();
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
            firstName: firstNameTextEditingController.text.isEmpty
                ? ''
                : firstNameTextEditingController.text,
            lastName: lastNameTextEditingController.text.isEmpty
                ? ''
                : lastNameTextEditingController.text,
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
      registrationID: registrationIDTextEditingController.text.isEmpty
          ? ''
          : registrationIDTextEditingController.text,
    ));
  }

  void saveData() {
    List<String> buyerData =
        buyerList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList(buyerSharedPreferencesKey, buyerData);
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
