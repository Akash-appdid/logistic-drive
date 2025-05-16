import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/services/constants.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/extra_methods.dart';
import 'package:logistic_driver/views/screens/drawer_screens/components/icon_and_title_widget.dart';
import 'package:logistic_driver/views/screens/drawer_screens/profile_screens/profile_screen.dart';

import '../../../controllers/basic_controller.dart';
import '../../../services/route_helper.dart';
import '../../base/custom_html_screen.dart';
import '../../base/dialogs/delete_account_dialog.dart';
import '../../base/dialogs/logout_dialog.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<AuthController>(builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade200,
                              child: Text(
                                getInitialLetter(controller.userModel?.name),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (controller.userModel?.name ?? 'NA')
                                        .capitalizeFirstOfEach,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    controller.userModel?.phone ?? 'NA',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          color: const Color(0xff626161),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                      const Divider(color: Color(0xffDAD9D9)),
                      IconAndTitleWidget(
                          title: "Home",
                          icon: Icons.home_outlined,
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      IconAndTitleWidget(
                          title: "Profile",
                          icon: Icons.account_circle_outlined,
                          onTap: () {
                            Navigator.push(context,
                                getCustomRoute(child: const ProfileScreen()));
                          }),
                      const Divider(color: Color(0xffDAD9D9)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, bottom: 8.0, top: 8.0),
                        child: Text(
                          "Others",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                      const Divider(color: Color(0xffDAD9D9)),
                      IconAndTitleWidget(
                        title: "Terms and Conditions",
                        icon: Icons.description,
                        onTap: () {
                          Navigator.of(context).push(
                            getCustomRoute(
                              child: const CustomHtmlScreen(
                                title: 'Terms and Conditions',
                                bussinessSettingName:
                                    BussinessSettingName.termsAndCondition,
                              ),
                            ),
                          );
                        },
                      ),
                      IconAndTitleWidget(
                        title: "Privacy policy",
                        icon: Icons.security,
                        onTap: () {
                          Navigator.of(context).push(
                            getCustomRoute(
                              child: const CustomHtmlScreen(
                                title: 'Privacy Policy',
                                bussinessSettingName:
                                    BussinessSettingName.privacyPolicy,
                              ),
                            ),
                          );
                        },
                      ),
                      IconAndTitleWidget(
                        title: "About Us",
                        icon: Icons.info_outline,
                        onTap: () {
                          Navigator.of(context).push(
                            getCustomRoute(
                              child: const CustomHtmlScreen(
                                title: 'About Us',
                                bussinessSettingName:
                                    BussinessSettingName.aboutUs,
                              ),
                            ),
                          );
                        },
                      ),
                      IconAndTitleWidget(
                        title: "Support",
                        icon: Icons.support_agent_outlined,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const LogoutDialog();
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_sharp,
                      size: 24,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      "Logout",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DeleteAccountDialog();
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Icon(Icons.delete, size: 24, color: Colors.red),
                    const SizedBox(width: 14),
                    Text(
                      "Delete Account",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Version ${AppConstants.version}:${AppConstants.buildNumber}",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
