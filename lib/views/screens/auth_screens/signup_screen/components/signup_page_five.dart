import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

import '../../../../../services/input_decoration.dart';

import '../../../../base/image_picker_sheet.dart';

class SignUpPageFive extends StatefulWidget {
  const SignUpPageFive({super.key});

  @override
  State<SignUpPageFive> createState() => _SignUpPageFiveState();
}

class _SignUpPageFiveState extends State<SignUpPageFive> {
  TextEditingController payeeNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankBranchController = TextEditingController();
  File? cancelledCheck;

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
                        child: SvgPicture.asset(Assets.svgsBank))),
                const SizedBox(height: 25),
                Text(
                  "Add Your Bank Details",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  "Securely add your bank account to receive payments directly. Ensure your details are correct to avoid payment issues.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: payeeNameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: CustomDecoration.inputDecoration(
                    bgColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.grey,
                    borderRadius: 6,
                    label: 'Payee name',
                    hint: 'Enter Your Name',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: accountNumberController,
                  style: const TextStyle(color: Colors.black),
                  decoration: CustomDecoration.inputDecoration(
                    bgColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.grey,
                    borderRadius: 6,
                    label: 'Account number',
                    hint: 'Enter account number',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: confirmAccountNumberController,
                  style: const TextStyle(color: Colors.black),
                  decoration: CustomDecoration.inputDecoration(
                    bgColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.grey,
                    borderRadius: 6,
                    label: 'Confirm account number',
                    hint: 'Enter confirm account number',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: ifscController,
                  style: const TextStyle(color: Colors.black),
                  decoration: CustomDecoration.inputDecoration(
                    bgColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.grey,
                    borderRadius: 6,
                    label: 'IFSC code',
                    hint: 'Enter ifsc code',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: bankNameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: CustomDecoration.inputDecoration(
                    bgColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.grey,
                    borderRadius: 6,
                    label: 'Bank name',
                    hint: 'Enter bank name',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: bankBranchController,
                  style: const TextStyle(color: Colors.black),
                  decoration: CustomDecoration.inputDecoration(
                    bgColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.grey,
                    borderRadius: 6,
                    label: 'Bank branch',
                    hint: 'Enter bank branch',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: TextEditingController(text: cancelledCheck?.path.fileName ?? ""),
                  readOnly: true,
                  decoration: CustomDecoration.inputDecoration(
                      label: 'Cancelled Check',
                      bgColor: const Color(0xFFF8F8F8),
                      borderColor: Colors.grey,
                      borderRadius: 6,
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
                              cancelledCheck = await getImageBottomSheet(context);
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
