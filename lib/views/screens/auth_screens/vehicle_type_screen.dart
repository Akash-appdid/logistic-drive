import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';
import '../../base/common_button.dart';

class VehicleTypeScreen extends StatefulWidget {
  const VehicleTypeScreen({super.key});

  @override
  State<VehicleTypeScreen> createState() => _VehicleTypeScreenState();
}

class _VehicleTypeScreenState extends State<VehicleTypeScreen> {
  bool _isExpanded = false;

  List<String> languages = ["English", "Hindi", "Marathi", "Gujarati"];
  String? selectedLanguage;
  File? panCardFile;
  File? drivingLicenceFile;

  List vehicleType = [
    {"vehicle_type": "", "storage_type": "", "description": "", "image": Assets.images2Wheeler}
  ];

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
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(Assets.svgsTruck))),
                const SizedBox(height: 25),
                Text(
                  "Choose Your Vehicle to Start Delivering!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  "Become a delivery partner by selecting the vehicle you’ll use.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onTap: () {
                // Navigator.pushReplacement(context, getCustomRoute(child: VehicleTypeScreen()));
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
