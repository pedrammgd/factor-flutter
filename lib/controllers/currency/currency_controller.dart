import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/currency/currency_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxList<String> currencyList = <String>['ریال', 'تومان', 'دلار'].obs;

  Rxn<CurrencyViewModel> currencyViewModel = Rxn<CurrencyViewModel>();

  RxInt selectedCurrency = 1.obs;
  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadCurrencyData();
  }

  void loadCurrencyData() {
    String currencyData =
        sharedPreferences.getString(currencySharedPreferencesKey) ?? '';

    if (currencyData.isNotEmpty) {
      currencyViewModel.value =
          CurrencyViewModel.fromJson(jsonDecode(currencyData));
      print(currencyData);

      selectedCurrency.value = currencyViewModel.value!.currencyFormat;
    }
  }

  CurrencyViewModel get _customCurrencyDto {
    return CurrencyViewModel(currencyFormat: selectedCurrency.value);
  }

  void saveCurrencyData() {
    String currencyData = json.encode(_customCurrencyDto.toJson());
    sharedPreferences.setString(currencySharedPreferencesKey, currencyData);
  }
}
