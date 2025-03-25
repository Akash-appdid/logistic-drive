import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logistic_driver/services/constants.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/dashboard/profile_screens/profile_screen.dart';

import '../../../../services/route_helper.dart';
import '../../../base/dialogs/delete_account_dialog.dart';
import '../review_and_ratiing_screen/review_and_rating.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Menu",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const Divider(
                  height: 0.5,
                  color: Color(0xFF787878),
                ),
                const SizedBox(
                  height: 14,
                ),
                //
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, getCustomRoute(child: const ProfileScreen()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsMyProfile),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "My Profile",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsBookings),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "Bookings",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, getCustomRoute(child: ReviewScreen()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsReviewRating),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "Review & Ratings",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsTermsAndCondition),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "Terms and Conditions",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsPrivacyPolicy),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "Privacy policy",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsAboutUs),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "About Us",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsSupport),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "Support",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgsHelpSupport),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            "Help & Support",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {},
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        size: 24,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Delete Account",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Version ${AppConstants.version}:${AppConstants.buildNumber}",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
