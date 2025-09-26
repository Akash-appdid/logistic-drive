import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/firebase_options.dart';
import 'package:logistic_driver/services/constants.dart';
import 'package:logistic_driver/services/theme.dart';
import 'controllers/notification_controller.dart';
import 'controllers/one_signal_controller.dart';
import 'services/init.dart';
import 'views/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Init().initialize();
  await Init().intializeAppBuildInfo();
  await Init().stopAppRotation();
  await Get.find<NotificationController>().notificationInitMethod();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

//-----------baground notification---------------
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Baground notification received: ${message.toMap().toString()}',
      name: 'FCM');
  if (message.messageId != null) {
    log("Handling a background messageId: ${message.messageId}");
    log("Handling a background Data: ${message.data}");
    log('ID:${message.data['id']}', name: 'ID');
    /////
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
    Get.find<OneSingleController>().initPlatForm();
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
