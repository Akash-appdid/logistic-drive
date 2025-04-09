import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../../controllers/auth_controller.dart';
import '../../../../../controllers/otp_autofill_controller.dart';
import '../../../../../services/theme.dart';

class ResendOtpWidget extends StatelessWidget {
  const ResendOtpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPAutofillController>(builder: (controller) {
      return GetBuilder<AuthController>(builder: (auth) {
        return GestureDetector(
          onTap: controller.resendOtpTimer != 0
              ? null
              : () async {
                  Map<String, dynamic> data = {
                    'phone':
                        Get.find<AuthController>().numberController.text.trim(),
                    'app_signature': await controller.getAppSignature(),
                  };
                  log('$data');
                  auth.login(data: data).then((value) {
                    if (value.isSuccess) {
                      controller.startResendOtpTimer();
                      Fluttertoast.showToast(msg: 'OTP recent successful');
                    } else {
                      Fluttertoast.showToast(msg: value.message);
                    }
                  });
                },
          child: Column(
            children: [
              Text(
                "Didn't receive the code?",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              controller.resendOtpTimer != 0
                  ? Text(
                      ' in ${controller.resendOtpTimer} seconds',
                    )
                  : Text(
                      'Resend OTP',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                    ),
            ],
          ),
        );
      });
    });
  }
}
