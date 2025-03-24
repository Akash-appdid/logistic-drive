import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen.dart';
import 'package:pinput/pinput.dart'; // Import pinput package

import '../../../generated/assets.dart';
import '../../../services/route_helper.dart';
import '../../base/common_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isResendOtpEnabled = false;
  int _resendOtpTimer = 30;
  Timer? _timer;
  bool _isTextVisible = true;

  @override
  void initState() {
    super.initState();
    _startResendOtpTimer(); // Start the countdown when screen loads
  }

  void _startResendOtpTimer() {
    setState(() {
      _isResendOtpEnabled = false;
      _isTextVisible = true;
      _resendOtpTimer = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendOtpTimer == 0) {
        setState(() {
          _isResendOtpEnabled = true;
          _isTextVisible = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _resendOtpTimer--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: GetBuilder<AuthController>(builder: (authController) {
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
                        text: '+91 ${authController.numberController.text}',
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
                Pinput(
                  controller: _otpController,
                  length: 6,
                  onCompleted: (pin) {
                    print('OTP entered: $pin');
                  },
                  onChanged: (pin) {
                    print('OTP is changing: $pin');
                  },
                  defaultPinTheme: PinTheme(
                    width: 45,
                    height: 60,
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff3B4652)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // "Please wait for..." Text Visibility Control
                if (_isTextVisible)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Please wait for $_resendOtpTimer seconds to resend the OTP',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                      children: [
                        TextSpan(
                          text: '\nResend OTP',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: _isResendOtpEnabled
                                    ? const Color(0xff09596F) // Resend button enabled
                                    : Colors.grey, // Change color to gray while waiting
                              ),
                          recognizer: TapGestureRecognizer()..onTap = _isResendOtpEnabled ? _startResendOtpTimer : null, // Only allow resend after 30 seconds
                        ),
                      ],
                    ),
                  ),
                // If the "Please wait for..." text is hidden, just show the "Resend OTP" button
                if (!_isTextVisible)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '\nResend OTP',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: _isResendOtpEnabled
                                ? const Color(0xff09596F) // Resend button enabled
                                : Colors.grey, // Change color to gray while waiting
                          ),
                      recognizer: TapGestureRecognizer()..onTap = _startResendOtpTimer, // Restart the timer
                    ),
                  ),
                const SizedBox(height: 20),
                CustomButton(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      getCustomRoute(child: SignUpScreen()),
                      (route) => false,
                    );
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
