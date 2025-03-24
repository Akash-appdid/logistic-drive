import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/views/screens/auth_screens/opt_verification_screen.dart';

import '../../../services/input_decoration.dart';
import '../../../services/route_helper.dart';
import '../../base/common_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                Text(
                  "What’s your \n phone number?",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: authController.numberController,
                  keyboardType: TextInputType.phone,
                  decoration: CustomDecoration.inputDecoration(
                    floating: true,
                    label: 'Mobile Number',
                    icon: const Icon(
                      Icons.phone_in_talk_outlined,
                      size: 19,
                      color: Color(0xFF130F26),
                    ),
                    hint: 'Enter your mobile number',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 25),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By tapping next you\'re creating an account and you agree to the ',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: 'Terms & conditons',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: const Color(0xff09596F),
                              decoration: TextDecoration.underline,
                            ),
                        // style: TextStyle(
                        //   color: Color(0xff09596F),
                        //   decoration: TextDecoration.underline,
                        // ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: ' and acknowledge ',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      TextSpan(
                        text: 'Privacy policy',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: const Color(0xff09596F),
                              decoration: TextDecoration.underline,
                            ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                CustomButton(
                  radius: 5,
                  elevation: 0,
                  onTap: () {
                    if (authController.numberController.text.length == 10) {
                      Navigator.push(
                        context,
                        getCustomRoute(child: const OtpVerificationScreen()),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: "Enter Correct Mobile Number",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
