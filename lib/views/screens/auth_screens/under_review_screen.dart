import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

import '../../../controllers/basic_controller.dart';
import '../../base/custom_html_screen.dart';
import '../../base/dialogs/logout_dialog.dart';
import '../dashboard/dashboard_screen.dart';

class ProfileUnderReviewScreen extends StatelessWidget {
  const ProfileUnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.red,
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const LogoutDialog();
                },
              );
            },
            icon: Icon(
              Icons.logout_outlined,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: () async {
              final controller = Get.find<AuthController>();
              controller.getUserProfileData().then((value) {
                if (value.isSuccess) {
                  if (controller.userModel?.status == 'active') {
                    Navigator.of(context).pushAndRemoveUntil(
                      getCustomRoute(child: const DashboardScreen()),
                      (route) => false,
                    );
                  }
                }
              });
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomImage(
                    path: Assets.imagesProfileUnderReview,
                    fit: BoxFit.contain,
                    height: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Profile Under Review!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "We are in the process of reviewing your profile. This may take some time. You will be notified once your profile is approved. Thank you for your patience.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.of(context).push(
                        getCustomRoute(
                          child: const CustomHtmlScreen(
                            title: 'Support',
                            bussinessSettingName:
                                BussinessSettingName.contactUs,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Support",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
