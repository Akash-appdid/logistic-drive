import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/extra_methods.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/signup_screen.dart';
import 'package:logistic_driver/views/screens/drawer_screens/profile_screens/components/vehicle_info_widget.dart';
import 'package:page_transition/page_transition.dart';

import 'components/bank_info_widgte.dart';
import 'components/contact_info_widget.dart';
import 'components/documents_widget.dart';
import 'components/title_and_value.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          SizedBox(
            height: 32,
            child: CustomButton(
              elevation: 0,
              onTap: () {
                Navigator.of(context).push(
                  getCustomRoute(
                    child: const SignupScreen(isFrmProfile: true),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.edit,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Edit Profile',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return RefreshIndicator(
          color: Colors.white,
          onRefresh: () async {
            controller.getUserProfileData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      getInitialLetter(controller.userModel?.name),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    (controller.userModel?.name ?? 'NA').capitalizeFirstOfEach,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 6),
                if (controller.userModel?.email != null)
                  Center(
                    child: Text(
                      controller.userModel?.email ?? 'NA',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.black, fontSize: 13),
                    ),
                  ),
                const SizedBox(height: 10),
                const Divider(color: Color(0xFFD9D9D9)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeadingWidget(title: "Contact Info"),
                      const SizedBox(height: 8),
                      ContactInfoWidget(userModel: controller.userModel),
                      const SizedBox(height: 20),
                      const HeadingWidget(title: "Vehicle Info"),
                      const SizedBox(height: 8),
                      VehicleInfoWidget(userModel: controller.userModel),
                      const SizedBox(height: 8),
                      if (!(controller.userModel?.isBankInfoEmpty ?? false))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeadingWidget(title: "Bank info"),
                            const SizedBox(height: 8),
                            BankInfoWidget(userModel: controller.userModel),
                            const SizedBox(height: 8),
                          ],
                        ),
                      if (!(controller.userModel?.isDocumentEmpty ?? false))
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingWidget(title: "Documents"),
                            SizedBox(height: 8),
                            DocumentsWidget(),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
