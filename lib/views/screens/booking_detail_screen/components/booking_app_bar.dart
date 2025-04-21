import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

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
    actions: [
      GetBuilder<BookingController>(builder: (controller) {
        if (controller.isLoading) {
          const SizedBox.shrink();
        }
        return Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color:
                controller.setStatusOfBooking(controller.bookingsDetailData) ==
                        'intransit'
                    ? Colors.orange
                    : Colors.green,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  controller.setStatusOfBooking(
                              controller.bookingsDetailData) ==
                          'intransit'
                      ? Icons.local_shipping
                      : Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  controller
                      .setStatusOfBooking(controller.bookingsDetailData)
                      .capitalizeFirstOfEach,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      const SizedBox(width: 10),
    ],
  );
}
