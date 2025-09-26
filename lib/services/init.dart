import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/controllers/local_bike_tempo_controller.dart';
import 'package:logistic_driver/controllers/location_controller.dart';
import 'package:logistic_driver/controllers/notification_controller.dart';
import 'package:logistic_driver/controllers/otp_autofill_controller.dart';
import 'package:logistic_driver/controllers/packer_mover_controller.dart';
import 'package:logistic_driver/controllers/pusher_controller.dart';
import 'package:logistic_driver/controllers/register_controller.dart';
import 'package:logistic_driver/data/api/api_client.dart';
import 'package:logistic_driver/data/repositories/auth_repo.dart';
import 'package:logistic_driver/data/repositories/basic_repo.dart';
import 'package:logistic_driver/data/repositories/booking_repo.dart';
import 'package:logistic_driver/data/repositories/local_bike_tempo_booking_repo.dart';
import 'package:logistic_driver/data/repositories/packer_and_mover_repo.dart';
import 'package:logistic_driver/data/repositories/register_repo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/one_signal_controller.dart';
import '../controllers/permission_controller.dart';
import '../data/api/api_calls.dart';
import 'constants.dart';

class Init {
  getBaseUrl() async {
    ApiCalls calls = ApiCalls();
    await calls
        .apiCallWithResponseGet(
            'https://fishcary.com/fishcary/api/link2.php?for=true')
        .then((value) {
      log(value.toString());
      AppConstants().setBaseUrl = jsonDecode(value)['link'];
      log(AppConstants().getBaseUrl, name: 'BASE');
    });
  }

  initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);
    try {
      //-------Repo
      Get.lazyPut(() => ApiClient(
          appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
      Get.lazyPut(
          () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
      Get.lazyPut(() => BasicRepo(apiClient: Get.find()));
      Get.lazyPut(() => RegisterRepo(apiClient: Get.find()));
      Get.lazyPut(() => BookingRepo(apiClient: Get.find()));
      Get.lazyPut(() => PakerAndMoverRepo(apiClient: Get.find()));
      Get.lazyPut(() => LocalBikeTempoBookingRepo(apiClient: Get.find()));

      //--------Controller
      Get.lazyPut(() => PermissionController());
      Get.lazyPut(() => OneSingleController());
      Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Get.lazyPut(() => RegisterController(registerRepo: Get.find()));
      Get.lazyPut(() => BasicController(basicRepo: Get.find()));
      Get.lazyPut(() => BookingController(bookingRepo: Get.find()));
      Get.lazyPut(() => LocationController());
      Get.lazyPut(() => PusherController());
      Get.lazyPut(() =>
          LocalBikeTempoController(localBikeTempoBookingRepo: Get.find()));
      Get.lazyPut(
          () => PackerAndMoverController(pakerAndMoverRepo: Get.find()));
      Get.lazyPut(() => OTPAutofillController());
      Get.lazyPut(() => NotificationController());
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT initialize()");
    }
  }

  stopAppRotation() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  intializeAppBuildInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppConstants.appName = packageInfo.appName;
    AppConstants.packageName = packageInfo.packageName;
    AppConstants.version = packageInfo.version;
    AppConstants.buildNumber = packageInfo.buildNumber;
  }
}
