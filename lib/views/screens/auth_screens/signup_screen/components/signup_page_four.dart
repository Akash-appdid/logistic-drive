import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/components/aadhar_card_image.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/components/driving_licence_image.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/components/pancard_image.dart';

import 'components/aadhar_card_back_image.dart';

class SignupPageFour extends StatefulWidget {
  const SignupPageFour({super.key});

  @override
  State<SignupPageFour> createState() => _SignupPageFourState();
}

class _SignupPageFourState extends State<SignupPageFour> {
  File? drivingLicence;
  File? panCard;
  File? aadhaarCard;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(Assets.svgsKyc))),
                const SizedBox(height: 25),
                Text(
                  "Complete Your KYC Details(Optional)",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  "Verify your identity to start receiving payments securely. Upload the required documents to complete the KYC process.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 15),
                const PanCardImageWidget(),
                const SizedBox(height: 15),
                const DrivingLicenceImageWidget(),
                const SizedBox(height: 15),
                const AadharCardimageWidget(),
                const SizedBox(height: 15),
                const AadharCardBackImageWidget(),
                const SizedBox(height: 75),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
