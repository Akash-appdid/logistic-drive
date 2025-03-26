import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logistic_driver/services/constants.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/drawer_screens/profile_screens/profile_screen.dart';

import '../../../services/route_helper.dart';
import '../../base/dialogs/delete_account_dialog.dart';
import 'review_and_ratiing_screen/review_and_rating.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              const Divider(height: 0.5, color: Color(0xFF787878)),
              const SizedBox(height: 14),
              CustomDrawerTileWidget(
                title: "My Profile",
                icon: Assets.svgsMyProfile,
                onTap: () {
                  Navigator.push(context, getCustomRoute(child: const ProfileScreen()));
                },
              ),
              CustomDrawerTileWidget(
                title: "Bookings",
                icon: Assets.svgsBookings,
                onTap: () {},
              ),
              CustomDrawerTileWidget(
                title: "Review & Ratings",
                icon: Assets.svgsReviewRating,
                onTap: () {
                  Navigator.push(context, getCustomRoute(child: ReviewScreen()));
                },
              ),
              CustomDrawerTileWidget(
                title: "Terms and Conditions",
                icon: Assets.svgsTermsAndCondition,
                onTap: () {},
              ),
              CustomDrawerTileWidget(
                title: "Privacy policy",
                icon: Assets.svgsPrivacyPolicy,
                onTap: () {},
              ),
              CustomDrawerTileWidget(
                title: "About Us",
                icon: Assets.svgsAboutUs,
                onTap: () {},
              ),
              CustomDrawerTileWidget(
                title: "Support",
                icon: Assets.svgsSupport,
                onTap: () {},
              ),
              CustomDrawerTileWidget(
                title: "Help & Support",
                icon: Assets.svgsHelpSupport,
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: Column(
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
                    const Icon(Icons.delete, size: 24, color: Colors.red),
                    const SizedBox(width: 14),
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
    );
  }
}

class CustomDrawerTileWidget extends StatelessWidget {
  const CustomDrawerTileWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });
  final Function()? onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
            )
          ],
        ),
      ),
    );
  }
}
