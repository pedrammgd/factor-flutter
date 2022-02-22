import 'dart:convert';
import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_header/factor_header_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/models/my_profile_view_model/my_profile_view_model.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FactorUnofficialSpecificationController extends GetxController {
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

  RxList<SpecificationCostViewModel> excessCostList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> cartList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> cashList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> onlinePayList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> checkPayList =
      <SpecificationCostViewModel>[].obs;

  TextEditingController excessCostTitleTextEditingController =
      TextEditingController();
  TextEditingController excessCostPriceTextEditingController =
      TextEditingController();

  TextEditingController cartTitleTextEditingController =
      TextEditingController();
  TextEditingController cartPriceTextEditingController =
      TextEditingController();

  TextEditingController cashTitleTextEditingController =
      TextEditingController();
  TextEditingController cashPriceTextEditingController =
      TextEditingController();

  TextEditingController onlinePayTitleTextEditingController =
      TextEditingController();
  TextEditingController onlinePayPriceTextEditingController =
      TextEditingController();

  TextEditingController checkPayTitleTextEditingController =
      TextEditingController();
  TextEditingController checkPayPriceTextEditingController =
      TextEditingController();

  RxDouble offsetScroll = 0.0.obs;
  final ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '1');
  GlobalKey<FormState> cartFormKey = GlobalKey<FormState>(debugLabel: '2');
  GlobalKey<FormState> cashFormKey = GlobalKey<FormState>(debugLabel: '3');
  GlobalKey<FormState> onlinePayFormKey = GlobalKey<FormState>(debugLabel: '4');
  GlobalKey<FormState> checkPayFormKey = GlobalKey<FormState>(debugLabel: '5');

  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isExpandedBottomSheet = false.obs;
  RxInt statusBracketKeyText = 0.obs;

  RxDouble totalPrice;
  final String taxation;
  final String discount;
  final String totalWordPrice;
  Rxn<BuyerViewModel> buyerItem = Rxn<BuyerViewModel>();
  Rxn<MyProfileViewModel> myProfileItem = Rxn<MyProfileViewModel>();
  Rxn<FactorHeaderViewModel> factorHeaderViewModel =
      Rxn<FactorHeaderViewModel>();
  RxBool isSelectedBuyerName = false.obs;
  RxBool isMyProfileItemNull = false.obs;
  Uuid uUid = const Uuid();

  FactorUnofficialSpecificationController({
    required this.factorUnofficialItemList,
    required this.totalPrice,
    required this.taxation,
    required this.discount,
    required this.totalWordPrice,
  });

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    loadMyProfileData();
    loadFactorHeaderData();
  }

  void loadMyProfileData() {
    final myProfileData =
        sharedPreferences.getString(myProfileSharedPreferencesKey) ?? '';

    if (myProfileData.isNotEmpty) {
      myProfileItem.value =
          MyProfileViewModel.fromJson(jsonDecode(myProfileData));
      isMyProfileItemNull(true);
      log(myProfileData);
    } else {
      log('isEmpty');
    }
  }

  void loadFactorHeaderData() {
    String factorHeaderData =
        sharedPreferences.getString(factorHeaderSharedPreferencesKey) ?? '';

    if (factorHeaderData.isNotEmpty) {
      factorHeaderViewModel.value =
          FactorHeaderViewModel.fromJson(jsonDecode(factorHeaderData));
      log(factorHeaderData);
    } else {
      log('isEmpty');
    }
  }

  void buttonOnTapItem({
    required RxList<SpecificationCostViewModel> listItem,
    required TextEditingController titleTextEditingController,
    required TextEditingController priceTextEditingController,
  }) {
    listItem.add(SpecificationCostViewModel(
        id: uUid.v4(),
        price: priceTextEditingController.text,
        title: titleTextEditingController.text));
    Get.back();

    priceTextEditingController.clear();
    titleTextEditingController.clear();
  }

  void buttonExcessCostAdd() {
    if (!formKey.currentState!.validate()) return;
    totalPlusPriceSpecific(
        excessCostPriceTextEditingController.text.replaceAll(RegExp(','), ''));

    buttonOnTapItem(
        listItem: excessCostList,
        titleTextEditingController: excessCostTitleTextEditingController,
        priceTextEditingController: excessCostPriceTextEditingController);
  }

  void buttonCashAdd() {
    if (!cashFormKey.currentState!.validate()) return;
    totalMinesPriceSpecific(
        cashPriceTextEditingController.text.replaceAll(RegExp(','), ''));
    buttonOnTapItem(
        listItem: cashList,
        titleTextEditingController: cashTitleTextEditingController,
        priceTextEditingController: cashPriceTextEditingController);
  }

  void buttonCartAdd() {
    if (!cartFormKey.currentState!.validate()) return;
    totalMinesPriceSpecific(
        cartPriceTextEditingController.text.replaceAll(RegExp(','), ''));
    buttonOnTapItem(
        listItem: cartList,
        titleTextEditingController: cartTitleTextEditingController,
        priceTextEditingController: cartPriceTextEditingController);
  }

  void buttonOnlinePayAdd() {
    if (!onlinePayFormKey.currentState!.validate()) return;
    totalMinesPriceSpecific(
        onlinePayPriceTextEditingController.text.replaceAll(RegExp(','), ''));
    buttonOnTapItem(
        listItem: onlinePayList,
        titleTextEditingController: onlinePayTitleTextEditingController,
        priceTextEditingController: onlinePayPriceTextEditingController);
  }

  void buttonCheckPayAdd() {
    if (!checkPayFormKey.currentState!.validate()) return;
    totalMinesPriceSpecific(
        checkPayPriceTextEditingController.text.replaceAll(RegExp(','), ''));
    buttonOnTapItem(
        listItem: checkPayList,
        titleTextEditingController: checkPayTitleTextEditingController,
        priceTextEditingController: checkPayPriceTextEditingController);
  }

  RxDouble totalPlusPriceSpecific(String price) {
    totalPrice.value += double.parse(price);
    if (totalPrice.value < 0) {
      statusBracketKeyText(1);
    } else if (totalPrice.value == 0) {
      statusBracketKeyText(3);
    } else {
      statusBracketKeyText(0);
    }
    return totalPrice;
  }

  RxDouble totalMinesPriceSpecific(String price) {
    totalPrice.value -= double.parse(price);
    if (totalPrice.value < 0) {
      statusBracketKeyText(1);
    } else if (totalPrice.value == 0) {
      statusBracketKeyText(3);
    } else {
      statusBracketKeyText(0);
    }
    return totalPrice;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
