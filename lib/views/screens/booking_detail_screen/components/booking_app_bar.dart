import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';

AppBar bookingAppBar(BuildContext context, {bool isFrmCarAndBike = false}) {
  return AppBar(
    title: GetBuilder<BookingController>(builder: (controller) {
      if (controller.isLoading) {
        return const SizedBox.shrink();
      }
      if (isFrmCarAndBike) {
        return Text(
          'ID #${(controller.carAndBokingDetailData?.bookingId ?? '').toUpperCase()}',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        );
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
