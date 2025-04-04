import 'package:flutter/material.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

import 'components/driving_otpverification_widget.dart';

class PikupLocationScreen extends StatelessWidget {
  const PikupLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking ID #23263513614',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: const CustomImage(
        width: double.infinity,
        height: double.infinity,
        path: Assets.imagesBigMap,
        fit: BoxFit.cover,
      ),
      bottomSheet:
          const DrivingOtpverificationWidget(), //const StartDrivingWidget(),
    );
  }
}
