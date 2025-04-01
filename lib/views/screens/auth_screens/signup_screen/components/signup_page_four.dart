import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

import '../../../../../services/input_decoration.dart';

import '../../../../base/image_picker_sheet.dart';

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
                    bgColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.grey,
                    borderRadius: 6,
                    label: 'Pan Card',
                    suffix: Container(
                      width: 120,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            panCard = await getImageBottomSheet(context);
                            setState(() {});
                          },
                          child: const Text('Select file'),
                        ),
                      ),
                    ),
                    hint: 'Pan Card',
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: TextEditingController(text: drivingLicence?.path.fileName ?? ""),
                  readOnly: true,
                  decoration: CustomDecoration.inputDecoration(
                      bgColor: const Color(0xFFF8F8F8),
                      borderColor: Colors.grey,
                      borderRadius: 6,
                      label: 'Driving Licence',
                      suffix: Container(
                        width: 120,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: GestureDetector(
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
                      bgColor: const Color(0xFFF8F8F8),
                      borderColor: Colors.grey,
                      borderRadius: 6,
                      label: 'Aadhaar Card',
                      suffix: Container(
                        width: 120,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: GestureDetector(
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
    );
  }
}
