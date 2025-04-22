import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';

AppBar bookingAppBar(BuildContext context) {
  return AppBar(
    title: GetBuilder<BookingController>(builder: (controller) {
      if (controller.isLoading) {
        const SizedBox.shrink();
      }
      return Text(
        'ID #${(controller.bookingsDetailData?.bookingId ?? '').toUpperCase()}',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      );
    }),
    actions: const [
      SizedBox(width: 10),
    ],
  );
}
