import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends GetxController implements GetxService {
  String? savedFcmToken;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> notificationInitMethod() async {
    await _requestNotificationPermission();

    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      log(fcmToken, name: "FCM TOKEN");
      savedFcmToken = fcmToken;
      update();
    }
    await initializeNotifications();
    await initializeFirebaseMessaging();
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.request();
    log('Notification permission status: $status', name: 'Permission');
  }

  Future<void> initializeFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        log('App opened from terminated state with data: ${message.data}',
            name: 'FCM');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          handleMessageNavigation(message);
        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground notification received: ${message.toMap().toString()}',
          name: 'FCM');
      Timer.run(
        () {
          // handleForgroundmessage(message);
        },
      );
      if (Platform.isAndroid) {
        showLocalNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Notification opened: ${message.notification?.apple?.sound?.name}',
          name: 'FCM');
      handleMessageNavigation(message);
    });
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // Handle notification tap on iOS/Android
        log("Notification tapped with payload: ${notificationResponse.payload}",
            name: "LocalNotification");
      },
    );
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        // sound: 'notification_sound.wav',
        );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
    );
  }

  void handleMessageNavigation(RemoteMessage message) {
    if (message.data['id'] != null) {
      // Navigator.of(navigatorKey.currentContext!).push(
      //   getCustomRoute(
      //     child: ProductDetailScreen(
      //       listingData: Listing(
      //         listingImages: [],
      //         favourite: [],
      //         id: int.tryParse(message.data['id']) ?? 0,
      //       ),
      //     ),
      //   ),
      // );
    }
  }

  // void handleForgroundmessage(RemoteMessage message) {
  //   log(message.toMap().toString(), name: "Message");

  //   if (message.data.isNotEmpty) {
  //     var decoded = message.data;
  //     log(decoded.toString(), name: "Test");
  //     log(message.toString(), name: "Message");
  //     if (decoded['status'] == "delivered")
  //       Get.find<BasicController>().getongoingorders();
  //     var orderId = decoded['order_id'];

  //     if (orderId is String) {
  //       log("orderid is String");
  //       orderId = int.tryParse(orderId);
  //     }
  //     if (decoded["vertical_type"] == "grocery" &&
  //         orderId != null &&
  //         orderId == Get.find<OrderController>().orderdetails?.id) {
  //       Get.find<OrderController>()
  //           .getOrderById(orderId, isfromnotification: true);
  //     } else if (decoded["vertical_type"] == "restaurant" &&
  //         orderId != null &&
  //         orderId == Get.find<RestaurantOrderController>().orderdetails?.id) {
  //       Get.find<RestaurantOrderController>()
  //           .getOrderById(orderId, isfromnotification: true);
  //     }
  //   }
  // }
}
