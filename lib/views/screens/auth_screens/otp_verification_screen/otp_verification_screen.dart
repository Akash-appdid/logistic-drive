import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/otp_autofill_controller.dart';
import 'package:logistic_driver/views/screens/dashboard/dashboard_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../generated/assets.dart';
import '../../../../services/route_helper.dart';
import '../../../base/common_button.dart';
import '../signup_screen/signup_screen.dart';
import '../under_review_screen.dart';
import 'components/resend_otp_widget.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: GetBuilder<OTPAutofillController>(dispose: (state) {
        Get.find<OTPAutofillController>().currentCode = '';
      }, initState: (_) {
        Get.find<OTPAutofillController>().startResendOtpTimer();
      }, builder: (otpController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: SvgPicture.asset(Assets.svgsOtpverficationlockicon)),
                const SizedBox(height: 25),
                Text(
                  "Verify Your Code",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'We have sent the verification to ',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                        text:
                            '+91 ${Get.find<AuthController>().numberController.text}',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                      verifyOtp(
                          context, otpController, Get.find<AuthController>());
                    }
                  },
                  codeLength: 6,
                ),
                const SizedBox(height: 20),
                if (otpController.isTextVisible)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Please wait for ${otpController.resendOtpTimer} seconds to resend the OTP',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14),
                      children: [
                        TextSpan(
                          text: '\nResend OTP',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: otpController.isResendOtpEnabled
                                    ? const Color(0xff09596F)
                                    : Colors.grey,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = otpController.isResendOtpEnabled
                                ? otpController.startResendOtpTimer
                                : null,
                        ),
                      ],
                    ),
                  ),
                if (!otpController.isTextVisible) const ResendOtpWidget(),
                const SizedBox(height: 20),
                GetBuilder<AuthController>(builder: (authController) {
                  return CustomButton(
                    isLoading: authController.isLoading,
                    onTap: () {
                      verifyOtp(context, otpController, authController);
                    },
                    child: const Text(
                      "Verify OTP",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
  //------------otp verify-----------

  void verifyOtp(BuildContext context, OTPAutofillController otpController,
      AuthController authController) {
    Map<String, dynamic> data = {
      "phone": authController.numberController.text.trim(),
      "otp": otpController.currentCode,
    };
    log("$data");
    if (otpController.currentCode.isNotEmpty) {
      authController.verifyOTP(data).then((value) {
        if (value.isSuccess) {
          log(value.message);
          if (value.message == 'new') {
            Navigator.pushAndRemoveUntil(
              context,
              getCustomRoute(child: const SignupScreen()),
              (route) => false,
            );
          } else if (value.message == 'old') {
            authController.getUserProfileData().then(
              (value) {
                if (value.isSuccess) {
                  if (authController.userModel?.status == 'pending') {
                    Navigator.of(context).pushAndRemoveUntil(
                        getCustomRoute(child: const ProfileUnderReviewScreen()),
                        (route) => false);
                  } else if (authController.userModel?.status == 'active') {
                    Navigator.of(context).pushAndRemoveUntil(
                        getCustomRoute(child: const DashboardScreen()),
                        (route) => false);
                  }
                }
              },
            );
          }
        } else {
          Fluttertoast.showToast(msg: value.message);
        }
      });
    } else {
      Fluttertoast.showToast(msg: 'Please Enter OTP!');
    }
  }
}
