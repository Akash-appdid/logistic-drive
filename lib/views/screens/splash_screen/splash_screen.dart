import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import 'package:logistic_driver/services/constants.dart';
import 'package:logistic_driver/services/route_helper.dart';

import 'package:logistic_driver/views/screens/auth_screens/signup_screen/signup_screen.dart';
import 'package:logistic_driver/views/screens/auth_screens/under_review_screen.dart';
import 'package:logistic_driver/views/screens/dashboard/dashboard_screen.dart';
import 'package:logistic_driver/views/screens/welcome_screen/welcome_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../controllers/auth_controller.dart';
import '../../base/custom_image.dart';
import '../../base/dialogs/maintenance_dialog.dart';
import '../../base/dialogs/update_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      splashInitMethod();
    });
  }

  void splashInitMethod() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Get.find<BasicController>().getBussinessSetting().then((value) {
      var setting = Get.find<BasicController>();
      if (setting.getAppLinkAndAppVersion('user_android_maintenance_mode') !=
              null &&
          setting.getAppLinkAndAppVersion('user_android_maintenance_mode') ==
              '1') {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const MaintenanceDialog(),
        );
      } else if (int.parse(packageInfo.buildNumber) <
          int.parse(
              setting.getAppLinkAndAppVersion('user_app_version') ?? '0')) {
        if (Platform.isAndroid) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => UpdateDialog(
              remark: 'Please update app to the latest version',
              skip: ((setting.getAppLinkAndAppVersion(
                              'user_force_update_android') !=
                          null &&
                      setting.getAppLinkAndAppVersion(
                              'user_force_update_android') ==
                          '0'))
                  ? true
                  : false,
            ),
          ).then((value) {
            if (value) {
              initMethod();
            }
          });
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => UpdateDialog(
              remark: 'Please update app to the latest version',
              skip: ((setting.getAppLinkAndAppVersion('force_update_ios') !=
                          null &&
                      setting.getAppLinkAndAppVersion('force_update_ios') ==
                          '0'))
                  ? true
                  : false,
            ),
          ).then((value) {
            if (value) {
              initMethod();
            }
          });
        }
      } else {
        initMethod();
      }
    });
  }

  void initMethod() {
    final auth = Get.find<AuthController>();

    if (auth.isLoggedIn()) {
      auth.getUserProfileData().then((value) {
        if (value.isSuccess) {
          if (auth.userModel?.status == 'pending') {
            Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const ProfileUnderReviewScreen()),
                (route) => false);
            return;
          }
          if (Get.find<AuthController>().checkUserData()) {
            Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const DashboardScreen()),
                (route) => false);
          } else {
            if (auth.userModel != null) {
              auth.setNumber();
            }
            Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const SignupScreen()), (route) => false);
          }
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              getCustomRoute(child: const WelcomeScreen()), (route) => false);
        }
      });
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          getCustomRoute(child: const WelcomeScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              path: Assets.imagesAppLogo,
              height: appSizeHeight * .2,
              width: appSizeHeight * .2,
            ),
          ],
        ),
      ),
    );
  }
}
