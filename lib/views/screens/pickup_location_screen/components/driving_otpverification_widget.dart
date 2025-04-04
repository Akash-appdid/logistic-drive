import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

class DrivingOtpverificationWidget extends StatelessWidget {
  const DrivingOtpverificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'OTP Verification',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              'Authenticate with One-Time Password',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 16),
            PinFieldAutoFill(
              decoration: BoxLooseDecoration(
                strokeColorBuilder: const FixedColorBuilder(Colors.grey),
              ),
              onCodeChanged: (code) async {},
              codeLength: 6,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                onTap: () {},
                title: 'Submit',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
