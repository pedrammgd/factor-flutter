import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/currency/currency_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/hive/factor_view_model_hive.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/factor_unofficial_specification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_number_utility/src/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/store/hive/store_item_view_model_hive.dart';

class StoreController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    openBoxHive();
    scrollController.addListener(() {
      offsetScroll.value = scrollController.offset;
      if (offsetScroll.value > 50 && boxStore.value!.length > 2) {
        isExpandedBottomSheet(false);
      }
    });
  }


  final bool isFromUnofficialFactor;

  StoreController({ this.isFromUnofficialFactor = false});

  Rxn<Box> boxStore= Rxn<Box>();
  void openBoxHive() async {
    isLoading(true);

    boxStore.value =
    await Hive.openBox<StoreItemViewModelHive>('storeHV');
    initSharedPreferences();


  }

  Rxn<CurrencyViewModel> currencyViewModel = Rxn<CurrencyViewModel>();

  final ScrollController scrollController = ScrollController();
  RxDouble offsetScroll = 0.0.obs;

  RxBool isLoading = true.obs;
  RxBool isExpandedBottomSheet = true.obs;

  // RxList<StoreItemViewModelHive> storeItemList =
  //     <StoreItemViewModelHive>[].obs;


  final List<String> popUpItems = <String>[
    Constants.editPopUp,
    Constants.removePopUp
  ];

  // double price() {
  //   double _price = 0;
  //   for (var element in boxStore.value as List<StoreItemViewModelHive> ) {
  //     _price += int.parse(element.productUnitPrice) * element.productCount;
  //   }
  //   return _price;
  // }





  // RxDouble totalPrice() {
  //   RxDouble _totalPrice = 0.0.obs;
  //
  //   _totalPrice.value = price() ;
  //
  //   return _totalPrice;
  // }

  double totalPriceItem(StoreItemViewModelHive item) {
    double _totalPrice = 0;

    _totalPrice += (int.parse(item.productUnitPrice) * item.productCount);


    return _totalPrice;
  }

  late SharedPreferences sharedPreferences;

  initSharedPreferences() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();

      loadCurrencyData();
      isLoading.value = false;
    });
  }





  void removeItem(int index) {
    boxStore.value?.deleteAt(index);
    openBoxHive();
  }


  void loadCurrencyData() {
    String currencyData =
        sharedPreferences.getString(currencySharedPreferencesKey) ?? '';

    if (currencyData.isNotEmpty) {
      currencyViewModel.value =
          CurrencyViewModel.fromJson(jsonDecode(currencyData));
      print(currencyData);
    }
  }

  String currencyTitle() {
    if (currencyViewModel.value == null) {
      return 'تومان';
    } else if (currencyViewModel.value?.currencyFormat == 0) {
      return 'ریال';
    } else if (currencyViewModel.value?.currencyFormat == 1) {
      return 'تومان';
    } else {
      return 'دلار';
    }
  }
}
