import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';

AppBar bookingAppBar(BuildContext context) {
  return AppBar(
    title: GetBuilder<BookingController>(builder: (controller) {
      if (controller.isLoading) {
        return const SizedBox.shrink();
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
      // GetBuilder<BookingController>(builder: (controller) {
      //   return SizedBox(
      //     height: 55,
      //     child: StatusWidget(
      //       bookings: controller.bookingsDetailData ?? BookingsModel(),
      //     ),
      //   );
      // }),
      SizedBox(width: 10),
    ],
  );
}
