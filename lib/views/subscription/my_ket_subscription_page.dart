import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/subscription_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myket_iap/myket_iap.dart';
import 'package:myket_iap/util/iab_result.dart';
import 'package:myket_iap/util/inventory.dart';
import 'package:myket_iap/util/purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyKetSubscriptionPage extends StatefulWidget {
  const MyKetSubscriptionPage({Key? key}) : super(key: key);

  @override
  _MyKetSubscriptionPageState createState() => _MyKetSubscriptionPageState();
}

class _MyKetSubscriptionPageState extends State<MyKetSubscriptionPage> {
  bool _loading = true;

  @override
  void initState() {
    initIab();
    super.initState();
    initSharedPreferences();
    connectionInternet();
  }

  Future connectionInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _loading = true;
    }
  }

  late SharedPreferences sharedPreferences;
  String subscriptionValue = '';

  initSharedPreferences() {
    // isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();

      loadSubscription();
      // isLoading.value = false;
    });
  }

  void saveSubscription(String value) {
    sharedPreferences.setString(subscriptionSharedPreferencesKey, value);
  }

  void loadSubscription() {
    String subscriptionData =
        sharedPreferences.getString(subscriptionSharedPreferencesKey) ?? '';
    if (subscriptionData.isNotEmpty) {
      subscriptionValue = subscriptionData;
    }
    log('loadSubscriptionsssssss${subscriptionData}');
  }

  @override
  void dispose() {
    MyketIAP.dispose();
    super.dispose();
  }

  initIab() async {
    var rsa =
        "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3hogbLzChH5Ciatd2DH5dnUYqSi8TBFIyMQERHrpfvus3xlzDXcQPBSQ0KN0ff120/3ZvR8yW2YMro7GXDXgEyFOtsM72XuKomnXUTgNWnXZ+9XQ7QOubPBj7LO8x8X45m+DhFPPIuGJy/4GPzYKl5Rxg7EeR/UYrEFHSa6XHbQIDAQAB";
    var iabResult = await MyketIAP.init(rsaKey: rsa, enableDebugLogging: true);
    if (iabResult?.isFailure() == true) {
      // Oh noes, there was a problem.
      Get.snackbar(
        'خطا در اتصال',
        'ابتدا از اتصال خود به حساب مایکت یا اینترنت مطمعن شوید',
      );
      return;
    }

    try {
      // IAB is fully set up. Now, let's get an inventory of stuff we own.
      print("Setup successful. Querying inventory.");
      var queryInventoryMap =
          await MyketIAP.queryInventory(querySkuDetails: false);
      IabResult inventoryResult = queryInventoryMap[MyketIAP.RESULT];
      Inventory inventory = queryInventoryMap[MyketIAP.INVENTORY];

      // Is it a failure?
      if (inventoryResult.isFailure()) {
        Get.snackbar(
          'خطا در اتصال',
          'ابتدا از اتصال خود به اینترنت مطمعن شوید',
        );
        return;
      }
      print("Query inventory was successful.");
      print('gasPurchasegasPurchase${subscriptionValue}');
    } catch (e) {
      Get.snackbar(
        'خطا در اتصال',
        'ابتدا از اتصال خود به اینترنت مطمعن شوید',
      );
    }

    setState(() => _loading = false);
  }

  buyFactor(int index) async {
    setState(() => _loading = true);

    String payload = "";

    try {
      var purchaseResultMap = await MyketIAP.launchPurchaseFlow(
          sku: skuBuy(index), payload: payload);
      IabResult purchaseResult = purchaseResultMap[MyketIAP.RESULT];
      Purchase purchase = purchaseResultMap[MyketIAP.PURCHASE];

      if (purchaseResult.isFailure()) {
        Get.snackbar('خرید ناموفق', 'خرید ناموفق مجددا تلاش کنید',
            backgroundColor: Colors.red);
        setState(() => _loading = false);

        return;
      }
      saveSubscription(purchase.mSku);
      Get.back(result: true);
      Get.snackbar('عملیات موفق', '${titleCard(index)} برای شما فعال شد ',
          backgroundColor: Colors.green);
      setState(() => _loading = false);
    } catch (e) {
      Get.snackbar('خرید ناموفق', 'خرید ناموفق مجددا تلاش کنید',
          backgroundColor: Colors.red);
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        // isEnterToBazar = true;
        return true;
      },
      child: Scaffold(
        appBar: FactorAppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'اشتراک',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            customBackButtonFunction: () {
              Get.back(result: true);
              // isEnterToBazar = true;
            }),
        body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child:
                // isEnterToBazar
                //     ?
                _listSubscription()),
      ),
    ));
  }

  Widget _listSubscription() {
    return FadeInRight(
      child: ListView(children: _itemListSub()),
    );
  }

  List<Widget> _itemListSub() {
    return List.generate(
        3,
        (index) => SubscriptionCardWidget(
            isLoading: _loading,
            backGroundColor: colorsCard[index],
            price: priceCard(index),
            description: descriptionCard(index),
            title: titleCard(index),
            icon: iconCard(index),
            onTap: _loading ? null : () => buyFactor(index)));
  }

  String titleCard(int index) {
    switch (index) {
      case 0:
        return 'اشتراک برنزی';
      case 1:
        return 'اشتراک نقره ای';
      default:
        return 'اشتراک طلایی';
    }
  }

  String iconCard(int index) {
    switch (index) {
      case 0:
        return bronzeCupIcon;
      case 1:
        return silverCupIcon;
      default:
        return goldCupIcon;
    }
  }

  String priceCard(int index) {
    switch (index) {
      case 0:
        return '19,000 تومان';
      case 1:
        return '49,000 تومان';
      default:
        return '59,000 تومان';
    }
  }

  String descriptionCard(int index) {
    switch (index) {
      case 0:
        return '29 فاکتور به صورت دائمی و مشتریان نامحدود بدون اشتراک سالانه';
      case 1:
        return '59 فاکتور به صورت دائمی و مشتریان نامحدود بدون اشتراک سالانه + حذف متن فاکتور پر';
      default:
        return 'بینهایت فاکتور به صورت دائمی و مشتریان نامحدود بدون اشتراک سالانه + حذف تبلیغات + حذف متن فاکتور پر + انبار';
    }
  }

  List<Color> colorsCard = <Color>[
    bronzeColor,
    silverColor,
    goldColor,
  ];

  String skuBuy(int index) {
    switch (index) {
      case 0:
        return 'bronze_buy';
      case 1:
        return 'silver';
      default:
        return 'gold';
    }
  }
}
