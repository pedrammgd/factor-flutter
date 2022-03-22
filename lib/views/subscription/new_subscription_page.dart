import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_product_model/factor_product_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/factor_circular_progress_indicator.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/subscription_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poolakey/flutter_poolakey.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewSubscriptionPage extends StatefulWidget {
  const NewSubscriptionPage({Key? key}) : super(key: key);

  @override
  State<NewSubscriptionPage> createState() => _NewSubscriptionPageState();
}

class _NewSubscriptionPageState extends State<NewSubscriptionPage> {
  final Map<String, ProductItem> _productsMap = {};

  int coins = 4;
  List<Color> bacGroundColor = <Color>[
    bronzeColor,
    silverColor,
    goldColor,
  ];
  bool isEnterToBazar = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initShop(0);
    initSharedPreferences();
  }

  Future<void> _initShop(int tryCount) async {
    _productsMap["bronze_buy"] = ProductItem(bronzeCupIcon, false);
    _productsMap["silver"] = ProductItem(silverCupIcon, false);
    _productsMap["gold"] = ProductItem(goldCupIcon, false);

    var message = "pedram";
    var rsaKey =
        "MIHNMA0GCSqGSIb3DQEBAQUAA4G7ADCBtwKBrwC3GmsXxlUYD9F//22IBEBUBBZ2I4BsDzxjfMc/6eGS7iYt4jhExxoiX3dBsrPrr0MXoZ3ZYZW4KzxiFgXix1CVYEDu6OUXTOuzDz8hFvZYBykfg39EH4g5zrBi6weUA0do0A6IYpD7RwNOaHFqX2G+zpjzTHYUKjLcIr+bohSdiCpK6saqfbgAbheWXHkujyDktd3+aCo6ylvlxO8HpAjfTEMPS39adCnM9Uw5FCcCAwEAAQ==";
    bool connected = false;
    try {
      connected = await FlutterPoolakey.connect(rsaKey, onDisconnected: () {
        message = "Poolakey disconnected!";
        log('connected${connected}');
      });
      isEnterToBazar = true;
    } on Exception catch (e) {
      message = e.toString();

      log('message${message}');
      if (mounted) {
        setState(() {
          isEnterToBazar = false;
        });
      }
    }
    if (!connected) {
      log('connected${message}');
      if (mounted) {
        setState(() {
          isEnterToBazar = false;

          return;
        });
      }
    }
    _reteriveProducts(tryCount);
  }

  Future<void> _reteriveProducts(int tryCount) async {
    try {
      isLoading = true;
      var purchases = await FlutterPoolakey.getAllPurchasedProducts();
      var subscribes = await FlutterPoolakey.getAllSubscribedProducts();
      var allPurchases = <PurchaseInfo>[];
      allPurchases.addAll(purchases);
      allPurchases.addAll(subscribes);
      for (var purchase in allPurchases) {
        _handlePurchase(purchase);
      }

      var skuDetailsList =
          await FlutterPoolakey.getInAppSkuDetails(_productsMap.keys.toList());

      for (var skuDetails in skuDetailsList) {
        _productsMap[skuDetails.sku]?.skuDetails = skuDetails;

        // inject purchaseInfo
        PurchaseInfo? purchaseInfo;
        for (var p in allPurchases) {
          if (p.productId == skuDetails.sku) purchaseInfo = p;
        }
        _productsMap[skuDetails.sku]?.purchaseInfo = purchaseInfo;
      }
      if (mounted) {
        setState(() {
          isEnterToBazar = true;
        });
      }
      isLoading = false;
    } catch (e) {
      isEnterToBazar = false;
      print(e.toString());

      Future.delayed(Duration(seconds: math.min(10, tryCount))).then((value) {
        if (!isEnterToBazar) _initShop(tryCount + 1);

        print(tryCount);

        // isEnterToBazar = false;

        // Future.delayed(const Duration(seconds: 5), () {
        // Get.back();
        // });
      });
    }
  }

  Future<void> _handlePurchase(PurchaseInfo purchase) async {
    log(purchase.originalJson);
    // log(purchase.productId);
    // log(purchase.dataSignature);
    if (purchase.productId == "bronze_buy") {
      if (coins < 5) coins = (coins + 1);
    } else if (purchase.productId == "silver") {
      coins = 5;
    } else if (purchase.productId == "gold") {
      coins = 10;
    }

    if (_productsMap[purchase.productId]!.consumable) {
      var result = await FlutterPoolakey.consume(purchase.purchaseToken);
      log(result.toString());
      if (!result) {
        log("object");
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  final RxList<FactorHomeViewModel> factorHomeList =
      <FactorHomeViewModel>[].obs;
  late SharedPreferences sharedPreferences;

  initSharedPreferences() {
    // isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      sharedPreferences = await SharedPreferences.getInstance();
      loadFactorData();
      loadSubscription();
      // isLoading.value = false;
    });
  }

  void loadFactorData() {
    List<String> factorDataList =
        sharedPreferences.getStringList(factorHomeListSharedPreferencesKey) ??
            [];
    if (factorDataList.isNotEmpty) {
      factorHomeList.value = factorDataList
          .map((e) => FactorHomeViewModel.fromJson(json.decode(e)))
          .toList();
    }
    // log('factorDataList${factorDataList}');
  }

  void saveSubscription(String value) {
    sharedPreferences.setString(subscriptionSharedPreferencesKey, value);
  }

  String subscriptionValue = '';

  void loadSubscription() {
    String subscriptionData =
        sharedPreferences.getString(subscriptionSharedPreferencesKey) ?? '';
    if (subscriptionData.isNotEmpty) {
      subscriptionValue = subscriptionData;
    }
    log('loadSubscriptionsssssss${subscriptionData}');
  }

  @override
  Widget build(BuildContext context) {
    final items = _productsMap.values.toList();
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        isEnterToBazar = true;
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
              isEnterToBazar = true;
            }),
        body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child:
                // isEnterToBazar
                //     ?
                _listViewBuilder(items)
            // : FadeInRight(
            //     child: SingleChildScrollView(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Image.asset(
            //             bazarIcon,
            //             width: 200,
            //             height: 150,
            //             fit: BoxFit.contain,
            //           ),
            //           const Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Text(
            //               'خطا در ارتباط با اینترنت یا کافه بازار جهت خرید یا ارتقا اشتراک خود،ابتدا وارد حساب کاربری خود در کافه بازار شوید',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(fontSize: 18),
            //             ),
            //           ),
            //           const Text(
            //             'خروج از این صفحه ، بعد از 5 ثانیه',
            //             style: TextStyle(color: Colors.red),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            ),
      ),
    );
  }

  FadeInRight _listViewBuilder(List<ProductItem> items) {
    return FadeInRight(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _itemListSub(index, items);
        },
      ),
    );
  }

  Widget _itemListSub(int index, List<ProductItem> items) {
    return SubscriptionCardWidget(
        isLoading: isLoading,
        backGroundColor: bacGroundColor[index],
        price: items[index].skuDetails == null
            ? '100'
            : items[index].skuDetails!.price,
        description: items[index].skuDetails == null
            ? 'توضیحات اشتراک'
            : items[index].skuDetails!.description,
        title: items[index].skuDetails == null
            ? 'اشتراک'
            : items[index].skuDetails!.title,
        icon: items[index].icon,
        onTap: () async {
          print('whhhhh${items[index].skuDetails}');
          if (!isEnterToBazar) {
            Get.snackbar(
              'خطا در اتصال',
              'ابتدا از اتصال خود به اینترنت یا کافه بازار مطمعن شوید',
            );
          }
          if (items[index].skuDetails == null) return;
          // if (index == 0 && subscriptionValue == 'silver') {
          //
          //   return;
          // } else if (index == 0 && subscriptionValue == 'gold') {
          //
          //   return;
          // } else if (index == 1 && subscriptionValue == 'gold') {
          //
          //   return;
          // }
          PurchaseInfo? purchaseInfo;
          try {
            purchaseInfo =
                await FlutterPoolakey.purchase(items[index].skuDetails!.sku);
            saveSubscription(items[index].skuDetails!.sku);
            _handlePurchase(purchaseInfo);
            Get.back(result: true);
            Get.snackbar('عملیات موفق',
                '${items[index].skuDetails?.title} برای شما فعال شد ',
                backgroundColor: Colors.green);
          } catch (e) {
            Get.snackbar('خرید ناموفق', 'خرید ناموفق مجددا تلاش کنید',
                backgroundColor: Colors.red);
            return;
          }
        });
  }
}
