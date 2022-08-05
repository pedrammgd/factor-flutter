import 'dart:developer';

import 'package:factor_flutter_mobile/main.dart';
import 'package:factor_flutter_mobile/models/ads/ads_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/repositories/ads/ads_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FactorBaseController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isShowFoundSearch = false.obs;
  RxBool isLoadingAd = false.obs;
  RxList<FactorHomeViewModel> factorHomeList = <FactorHomeViewModel>[].obs;
  RxList<AdsViewModel> adsViewModel = RxList<AdsViewModel>();
  final AdsRepository _repository = AdsRepository();

  RxList<FactorHomeViewModel> factorHomeListSearch =
      <FactorHomeViewModel>[].obs;

  TextEditingController searchEditingController = TextEditingController();

  void searchFactorHome(String value) {
    if (value.isEmpty) {
      isShowFoundSearch.value = false;
    } else {
      isShowFoundSearch.value = true;
    }
    factorHomeListSearch.value = factorHomeList.where((element) {
      final name = element.titleFactor.toLowerCase();
      final factorNum = element.numFactor.toLowerCase();
      return (name.contains(value.toLowerCase()) ||
          factorNum.contains(value.toLowerCase()));
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadAds();

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {},
        );

    FirebaseMessaging.onMessage.listen((message) {
      log('A Background message just showed up :  ${message.data}');

      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }

  Future<void> initializeLocalNotifications(BuildContext context,
      Map<String, dynamic> dataRequestNotification) async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(),
    );
    final initialized = await FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onSelectNotification: (payload) =>
          _onSelectNotification(context, dataRequestNotification),
    );
    print('_initializeLocalNotifications $initialized');

    const notificationChannel = AndroidNotificationChannel(
      'max_importance',
      'Max Importance',
      importance: Importance.max,
    );
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);
  }

  Future<void> _onSelectNotification(
      BuildContext context, Map<String, dynamic> dataRequestNotification) {
    return Future.value();
  }

  Future<void> loadAds() async {
    isLoadingAd(true);

    var resultOrException = await _repository.getAds();
    resultOrException.fold((exception) {
      print('eeeeeeeee${exception.error}');
    }, (List<AdsViewModel> r) {
      adsViewModel(r);
      print(r);
      isLoadingAd(false);
    });
  }
}
