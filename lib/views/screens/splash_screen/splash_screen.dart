import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/auth_screens/login_screen.dart';
import 'package:logistic_driver/views/screens/welcome_screen/welcome_screen.dart';

import '../../../services/constants.dart';
import '../../base/custom_image.dart';

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
      Future.delayed(const Duration(seconds: 2), () {
        if (kDebugMode) {
          Navigator.pushReplacement(
            context,
            getCustomRoute(
              child: const LoginScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            getCustomRoute(
              child: const WelcomeScreen(),
            ),
          );
        }
      });
      /*if (Get.find<AuthController>().isLoggedIn()) {
        Get.find<AuthController>().getUserProfileData().then((value) {
          Future.delayed(const Duration(seconds: 2), () {
            if (Get.find<AuthController>().checkUserData()) {
              Navigator.pushReplacement(
                context,
                getMaterialRoute(
                  child: const Dashboard(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                getMaterialRoute(
                  child: const SignupScreen(),
                ),
              );
            }
          });
        });
      } else {
        Navigator.pushReplacement(
          context,
          getMaterialRoute(
            child: const LoginScreen(),
          ),
        );
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              path: Assets.imagesLogo,
              height: size.height * .2,
              width: size.height * .2,
            ),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
