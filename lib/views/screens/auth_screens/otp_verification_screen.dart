import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/otp_autofill_controller.dart';

import 'package:logistic_driver/views/screens/auth_screens/signup_screen/signup_screen.dart';

import 'package:sms_autofill/sms_autofill.dart';

import '../../../generated/assets.dart';
import '../../../services/route_helper.dart';
import '../../base/common_button.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: GetBuilder<OTPAutofillController>(initState: (_) {
        Get.find<OTPAutofillController>().startResendOtpTimer();
      }, builder: (otpController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: SvgPicture.asset(Assets.svgsOtpverficationlockicon)),
                const SizedBox(height: 25),
                Text(
                  "Verify Your Code",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 15),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'We have sent the verification to ',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                        text: '+91 ${Get.find<AuthController>().numberController.text}',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Change Phone Number?",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 13, color: const Color(0xff009F0B)),
                  ),
                ),
                const SizedBox(height: 20),
                PinFieldAutoFill(
                  currentCode: otpController.currentCode,
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder: const FixedColorBuilder(Colors.grey),
                  ),
                  onCodeChanged: (code) async {
                    if (code == null) return;
                    otpController.updateCurrentCode(code);
                    if (otpController.currentCode.length == 6) {
                      FocusScope.of(context).unfocus();
                      // dynamic data = {
                      //   'type': "user",
                      //   'phone': auth.numberController.text.trim(),
                      //   'otp': currentCode,
                      //   'device_id': await Get.find<OneSingleController>().getDeviceId(),
                      // };
                      // log('$data');
                    }
                  },
                  codeLength: 6,
                ),
                const SizedBox(height: 20),

                if (otpController.isTextVisible)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Please wait for ${otpController.resendOtpTimer} seconds to resend the OTP',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                      children: [
                        TextSpan(
                          text: '\nResend OTP',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: otpController.isResendOtpEnabled
                                    ? const Color(0xff09596F) // Resend button enabled
                                    : Colors.grey, // Change color to gray while waiting
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                otpController.isResendOtpEnabled ? otpController.startResendOtpTimer : null, // Only allow resend after 30 seconds
                        ),
                      ],
                    ),
                  ),
                // If the "Please wait for..." text is hidden, just show the "Resend OTP" button
                if (!otpController.isTextVisible)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '\nResend OTP',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: otpController.isResendOtpEnabled
                                ? const Color(0xff09596F) // Resend button enabled
                                : Colors.grey, // Change color to gray while waiting
                          ),
                      recognizer: TapGestureRecognizer()..onTap = otpController.startResendOtpTimer, // Restart the timer
                    ),
                  ),
                const SizedBox(height: 20),
                CustomButton(
                  onTap: () {
                    if (otpController.currentCode.isNotEmpty) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        getCustomRoute(child: const SignupScreen()),
                        (route) => false,
                      );
                    } else {
                      Fluttertoast.showToast(msg: 'Please Enter OTP!');
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
