import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/register_controller.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/components/canceled_check_image.dart';

import '../../../../../services/input_decoration.dart';

class SignUpPageFive extends StatelessWidget {
  const SignUpPageFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: GetBuilder<AuthController>(builder: (authCtrl) {
              final data = authCtrl.userModel;
              return GetBuilder<RegisterController>(builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10)),
                            child: SvgPicture.asset(Assets.svgsBank))),
                    const SizedBox(height: 25),
                    Text(
                      "Add Your Bank Details",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 30),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Securely add your bank account to receive payments directly. Ensure your details are correct to avoid payment issues.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      readOnly: data?.payeeName != null,
                      controller: controller.payeeName,
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
                      keyboardType: TextInputType.number,
                      readOnly: data?.accountNumber != null,
                      controller: controller.accountNumber,
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
                      readOnly: data?.ifscCode != null,
                      controller: controller.ifscCode,
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
                      readOnly: data?.bankName != null,
                      controller: controller.bankName,
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
                      readOnly: data?.bankBranch != null,
                      controller: controller.branchName,
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
                    const CancelCheckImageWidget(),
                    const SizedBox(height: 75),
                  ],
                );
              });
            }),
          ),
        ),
      ),
    );
  }
}
