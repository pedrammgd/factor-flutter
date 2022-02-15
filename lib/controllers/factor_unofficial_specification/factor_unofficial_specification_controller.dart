import 'dart:convert';
import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/models/my_profile_view_model/my_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorUnofficialSpecificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
    scrollController.addListener(() {
      print(scrollController.offset);
      offsetScroll.value = scrollController.offset;
    });
  }

  RxDouble offsetScroll = 0.0.obs;
  final ScrollController scrollController = ScrollController();

  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isExpandedBottomSheet = false.obs;

  final String totalPrice;
  final String taxation;
  final String discount;
  final String totalWordPrice;
  Rxn<BuyerViewModel> buyerItem = Rxn<BuyerViewModel>();
  Rxn<MyProfileViewModel> myProfileItem = Rxn<MyProfileViewModel>();
  RxBool isSelectedBuyerName = false.obs;
  RxBool isMyProfileItemNull = false.obs;

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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
