import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/currency/currency_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartFactorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  Rxn<CurrencyViewModel> currencyViewModel = Rxn<CurrencyViewModel>();
  late SharedPreferences sharedPreferences;

  initSharedPreferences() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();
      loadCurrencyData();
    });
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
