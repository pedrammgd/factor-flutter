import 'dart:developer';

import 'package:factor_flutter_mobile/core/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FactorBaseController extends GetxController {
  RxInt currentIndex = 0.obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();

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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
