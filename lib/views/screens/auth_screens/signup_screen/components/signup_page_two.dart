import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

class SignUpPageTwo extends StatefulWidget {
  const SignUpPageTwo({super.key});

  @override
  State<SignUpPageTwo> createState() => _SignUpPageTwoState();
}

class _SignUpPageTwoState extends State<SignUpPageTwo> {
  List<String> languages = ["English", "Hindi", "Marathi", "Gujarati"];
  String? selectedLanguage;
  File? panCardFile;
  File? drivingLicenceFile;

  dynamic selectedVehicleType;
  List vehicleType = [
    {
      "vehicle_type": "Motorbike (2-wheeler)",
      "storage_type": "Small Parcel",
      "description": "You wish to deliver using a motorcycle or scooter.",
      "image": Assets.images2Wheeler
    },
    {
      "vehicle_type": "Mini-Truck (Package Delivery)",
      "storage_type": "Large Package",
      "description":
          "you have a mini-truck and want to deliver large packages.",
      "image": Assets.imagesMiniTruck
    },
    {
      "vehicle_type": "Open Truck",
      "storage_type": "Bulky goods",
      "description": "Perfect for transporting large and bulky goods.",
      "image": Assets.imagesOpenTruck
    },
    {
      "vehicle_type": "Body Pack Truck",
      "storage_type": "Secure Storage",
      "description": "Ideal for high-volume deliveries with secure storage.",
      "image": Assets.imagesBodyPackTruck
    },
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
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(Assets.svgsTruck))),
                const SizedBox(height: 25),
                Text(
                  "Choose Your Vehicle to Start Delivering!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  "Become a delivery partner by selecting the vehicle you’ll use.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 15),
                ListView.separated(
                  itemCount: vehicleType.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final vehicle = vehicleType[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVehicleType = vehicle;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: selectedVehicleType == vehicle ? 2 : 1,
                            color: selectedVehicleType == vehicle
                                ? primaryColor
                                : const Color(0xFFD9D9D9),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    color: const Color(0xFFFFAE00),
                                    child: Text(
                                      vehicle["storage_type"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(fontSize: 11),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    vehicle["vehicle_type"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    vehicle["description"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            fontSize: 12, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            CustomImage(
                              path: vehicle["image"],
                              fit: BoxFit.contain,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
                const SizedBox(height: 75),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
