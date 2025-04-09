import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/otp_autofill_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/screens/auth_screens/otp_verification_screen/otp_verification_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../services/input_decoration.dart';
import '../../../../services/route_helper.dart';
import '../../../base/common_button.dart';
import 'components/tearm_and_condtion_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What’s your \nPhone number?",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: authController.numberController,
                    keyboardType: TextInputType.phone,
                    decoration: CustomDecoration.inputDecoration(
                      borderRadius: 4,
                      floating: true,
                      label: 'Mobile Number',
                      icon: const Icon(
                        Icons.phone_in_talk_outlined,
                        size: 19,
                        color: Color(0xFF130F26),
                      ),
                      hint: 'Enter your mobile number',
                    ),
                    validator: (val) {
                      if (val.isNotValid) {
                        return 'Enter Mobile Number';
                      } else if (val?.length != 10) {
                        return 'Enter 10 Digit Mobile Number';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const TearmAndCondtionWidget(),
                  const SizedBox(height: 30),
                  GetBuilder<AuthController>(builder: (authController) {
                    return CustomButton(
                      isLoading: authController.isLoading,
                      radius: 5,
                      elevation: 0,
                      onTap: !authController.acceptTermAndCondition
                          ? null
                          : () async {
                              Map<String, dynamic> data = {
                                'phone': authController.numberController.text,
                                'app_signature':
                                    await Get.find<OTPAutofillController>()
                                        .getAppSignature(),
                              };
                              log('$data');
                              if (_formKey.currentState!.validate()) {
                                authController.login(data: data).then((value) {
                                  if (value.isSuccess) {
                                    Navigator.push(
                                      context,
                                      getCustomRoute(
                                        child: const OtpVerificationScreen(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(msg: value.message);
                                  }
                                });
                              }
                            },
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
