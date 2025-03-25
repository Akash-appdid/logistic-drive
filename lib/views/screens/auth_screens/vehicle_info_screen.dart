import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/base/date_picker_widget.dart';
import 'package:logistic_driver/views/screens/auth_screens/under_review_screen.dart';

import '../../../services/input_decoration.dart';
import '../../../services/route_helper.dart';
import '../../base/common_button.dart';
import '../../base/image_picker_sheet.dart';

class VehicleInfoScreen extends StatefulWidget {
  final dynamic vehicleType;
  const VehicleInfoScreen({super.key, this.vehicleType});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  bool isBike = false;
  File? registrationCertificate;
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController vehicleModel = TextEditingController();
  TextEditingController vehicleBuildYear = TextEditingController();

  @override
  void initState() {
    isBike = widget.vehicleType["vehicle_type"].contains("bike");
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
                        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(isBike ? Assets.svgsBike : Assets.svgsTruck))),
                const SizedBox(height: 25),
                Text(
                  "Tell Us About Your Vehicle",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  "Fill in the details to get started with quick and easy deliveries.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFD9D9D9),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBike ? "Two Wheeler" : "Mini Truck",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: vehicleNumber,
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomDecoration.inputDecoration(
                          borderWidth: 0,
                          borderColor: const Color(0xFFF8F8F8),
                          bgColor: const Color(0xFFF8F8F8),
                          floating: true,
                          label: 'Vehicle Number',
                          hint: 'MH-19-AG-5465',
                          hintStyle: const TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: TextEditingController(text: registrationCertificate?.path.fileName ?? ""),
                        readOnly: true,
                        decoration: CustomDecoration.inputDecoration(
                            floating: true,
                            label: 'Registration Certificate',
                            borderWidth: 0,
                            borderColor: const Color(0xFFF8F8F8),
                            bgColor: const Color(0xFFF8F8F8),
                            suffix: SizedBox(
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton(
                                  height: 20,
                                  color: Colors.white,
                                  onTap: () async {
                                    registrationCertificate = await getImageBottomSheet(context);
                                    setState(() {});
                                  },
                                  child: const Text('Select file'),
                                ),
                              ),
                            ),
                            hint: '',
                            hintStyle: const TextStyle(color: Colors.black87)),
                      ),
                      if (!isBike) ...[
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: vehicleModel,
                          style: const TextStyle(color: Colors.black),
                          decoration: CustomDecoration.inputDecoration(
                            borderWidth: 0,
                            borderColor: const Color(0xFFF8F8F8),
                            bgColor: const Color(0xFFF8F8F8),
                            floating: true,
                            label: 'Vehicle Model',
                            hint: 'Eicher Pro',
                            hintStyle: const TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomDatePicker(
                          datePickerMode: DatePickerMode.year,
                          onChanged: (DateTime? dateTime) {
                            if (dateTime != null) {
                              setState(() {
                                vehicleBuildYear.text = dateTime.year.toString();
                              });
                            }
                          },
                          today: false,
                          child: TextFormField(
                            controller: vehicleBuildYear,
                            style: const TextStyle(color: Colors.black),
                            enabled: false,
                            readOnly: true,
                            decoration: CustomDecoration.inputDecoration(
                              borderWidth: 0,
                              borderColor: const Color(0xFFF8F8F8),
                              bgColor: const Color(0xFFF8F8F8),
                              floating: true,
                              label: 'Build Year',
                              hint: '2022',
                              hintStyle: const TextStyle(
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 75),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onTap: () {
                Navigator.pushReplacement(context, getCustomRoute(child: const ProfileUnderReviewScreen()));
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
