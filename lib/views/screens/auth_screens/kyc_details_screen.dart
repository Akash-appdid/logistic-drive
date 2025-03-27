import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/auth_screens/bank_details_screen.dart';

import '../../../services/input_decoration.dart';
import '../../../services/route_helper.dart';
import '../../base/common_button.dart';
import '../../base/image_picker_sheet.dart';

class KycDetailsScreen extends StatefulWidget {
  const KycDetailsScreen({super.key});

  @override
  State<KycDetailsScreen> createState() => _KycDetailsScreenState();
}

class _KycDetailsScreenState extends State<KycDetailsScreen> {
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
                        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(Assets.svgsKyc))),
                const SizedBox(height: 25),
                Text(
                  "Complete Your KYC Details",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  "Verify your identity to start receiving payments securely. Upload the required documents to complete the KYC process.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: TextEditingController(text: panCard?.path.fileName ?? ""),
                  readOnly: true,
                  decoration: CustomDecoration.inputDecoration(
                      floating: true,
                      label: 'Pan Card',
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
                              panCard = await getImageBottomSheet(context);
                              setState(() {});
                            },
                            child: const Text('Select file'),
                          ),
                        ),
                      ),
                      hint: '',
                      hintStyle: const TextStyle(color: Colors.black87)),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: TextEditingController(text: drivingLicence?.path.fileName ?? ""),
                  readOnly: true,
                  decoration: CustomDecoration.inputDecoration(
                      floating: true,
                      label: 'Driving Licence',
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
                              drivingLicence = await getImageBottomSheet(context);
                              setState(() {});
                            },
                            child: const Text('Select file'),
                          ),
                        ),
                      ),
                      hint: '',
                      hintStyle: const TextStyle(color: Colors.black87)),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: TextEditingController(text: aadhaarCard?.path.fileName ?? ""),
                  readOnly: true,
                  decoration: CustomDecoration.inputDecoration(
                      floating: true,
                      label: 'Aadhaar Card',
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
                              aadhaarCard = await getImageBottomSheet(context);
                              setState(() {});
                            },
                            child: const Text('Select file'),
                          ),
                        ),
                      ),
                      hint: '',
                      hintStyle: const TextStyle(color: Colors.black87)),
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
                Navigator.pushReplacement(context, getCustomRoute(child: const BankDetailsScreen()));
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
