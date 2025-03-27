import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:logistic_driver/services/constants.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/splash_screen/splash_screen.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'services/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Init().initialize();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // AppConstants.appName = packageInfo.appName;
  AppConstants.packageName = packageInfo.packageName;
  AppConstants.version = packageInfo.version;
  AppConstants.buildNumber = packageInfo.buildNumber;
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  initPlatForm() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.none);

    OneSignal.initialize('appId'); //---------------------ADD ONESIGNAL APP ID
    OneSignal.User.pushSubscription.optIn();
    await OneSignal.consentRequired(true);

    OneSignal.Notifications.addForegroundWillDisplayListener((OSNotificationWillDisplayEvent event) {
      /// preventDefault to not display the notification
      event.preventDefault();

      /// Do async work
      /// notification.display() to display after preventing default
      event.notification.display();
    });

    OneSignal.Notifications.addClickListener((OSNotificationClickEvent result) {
      ///TODO:
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('Current state = $state');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatForm();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: AppConstants.appName,
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        theme: CustomTheme.light,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
