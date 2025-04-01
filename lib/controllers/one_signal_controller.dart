import 'dart:developer';

import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSingleController extends GetxController implements GetxService {
  static const String oneSignalAppId = 'AppId';

  initPlatForm() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.none);
    OneSignal.initialize(oneSignalAppId); // OneSignal App ID
    bool permissionGranted = await OneSignal.Notifications.requestPermission(true);
    log('Notification Permission Granted: $permissionGranted', name: 'PermissionStatus');
    if (permissionGranted) {
      OneSignal.User.pushSubscription.optIn();
    }
    await OneSignal.consentRequired(false);
    log('${OneSignal.User.pushSubscription.id}', name: 'ID');
    Future.delayed(const Duration(seconds: 10), () async {
      log('${OneSignal.User.pushSubscription.id}', name: 'PushSubscription_ID');
      final deviceId = await getDeviceId();
      log(deviceId, name: 'PushSubscription_ID');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((OSNotificationWillDisplayEvent event) {
      event.notification.display();
    });

    OneSignal.Notifications.addClickListener((OSNotificationClickEvent result) {
      log('Notification Clicked: ${result.notification.title}', name: 'NotificationClick');
    });
  }

  Future<String> getDeviceId() async {
    return OneSignal.User.pushSubscription.id ?? 'deviceID';
  }
}
