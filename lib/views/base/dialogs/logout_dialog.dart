import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logistic_driver/controllers/register_controller.dart';

import '../../../controllers/auth_controller.dart';
import '../../../services/route_helper.dart';
import '../../base/common_button.dart';
import '../../base/custom_image.dart';
import '../../screens/splash_screen/splash_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Center(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.red.withOpacity(0.8), BlendMode.srcATop),
                child: const CustomImage(
                  path: Assets.imagesExclaim,
                  color: Colors.white,
                  height: 40,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Are you sure you want to logout?",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    elevation: 0,
                    type: ButtonType.secondary,
                    title: 'Cancel',
                    height: 40,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                GetBuilder<AuthController>(builder: (auth) {
                  return Expanded(
                    child: CustomButton(
                      elevation: 0,
                      isLoading: auth.isLoading,
                      type: ButtonType.primary,
                      title: 'Logout',
                      height: 40,
                      onTap: () async {
                        await auth.logOut().then((value) {
                          auth.clearSharedData();
                          auth.cleanAllField();
                          Get.find<RegisterController>().cleanAllField();

                          Navigator.of(context).pushAndRemoveUntil(
                              getCustomRoute(child: const SplashScreen()),
                              (route) => false);
                        });
                      },
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
