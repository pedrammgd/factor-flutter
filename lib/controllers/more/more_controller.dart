import 'dart:developer';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/theme/factor_theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxBool isDark = false.obs;

  void changeTheme() {
    if (isDark.value) {
      Get.changeTheme(FactorTheme.darkTheme);
    } else {
      Get.changeTheme(FactorTheme.lightTheme);
    }
  }

  late SharedPreferences sharedPreferences;

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getTheme();
    loadSubscription();
  }

  void saveTheme() {
    sharedPreferences.setBool('saveTheme', isDark.value);
  }

  void getTheme() {
    isDark.value = sharedPreferences.getBool('saveTheme') ?? false;
    Get.changeTheme(
        isDark.value ? FactorTheme.darkTheme : FactorTheme.lightTheme);
  }

  RxString subscriptionValue = ''.obs;

  void loadSubscription() {
    String subscriptionData =
        sharedPreferences.getString(subscriptionSharedPreferencesKey) ?? '';
    if (subscriptionData.isNotEmpty) {
      subscriptionValue.value = subscriptionData;
    }
    log('loadSubscription${subscriptionData}');
  }

  RxString subscriptionTitle() {
    if (subscriptionValue.value == 'bronze_buy') {
      return 'اشتراک برنزی'.obs;
    } else if (subscriptionValue.value == 'silver') {
      return 'اشتراک نقره ای'.obs;
    } else if (subscriptionValue.value == 'gold') {
      return 'اشتراک طلایی'.obs;
    } else {
      return 'اشتراک رایگان'.obs;
    }
  }

  RxString subscriptionIcon() {
    if (subscriptionValue.value == 'bronze_buy') {
      return bronzeCupIcon.obs;
    } else if (subscriptionValue.value == 'silver') {
      return silverCupIcon.obs;
    } else if (subscriptionValue.value == 'gold') {
      return goldCupIcon.obs;
    } else {
      return coffeeCupIcon.obs;
    }
  }

  RxString subscriptionTextButton() {
    if (subscriptionValue.value == 'bronze_buy') {
      return 'ارتقا'.obs;
    } else if (subscriptionValue.value == 'silver') {
      return 'ارتقا'.obs;
    } else if (subscriptionValue.value == 'gold') {
      return 'بالاترین سطح'.obs;
    } else {
      return 'افزودن اشتراک'.obs;
    }
  }
}
