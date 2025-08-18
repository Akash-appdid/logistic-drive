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
    actions: [
      GetBuilder<BookingController>(
        builder: (controller) {
          final isDelivered = isFrmCarAndBike
              ? (controller.carAndBokingDetailData?.isDelivered ?? false)
              : (controller.bookingsDetailData?.isDelivered ?? false);

          if (!isDelivered) return const SizedBox.shrink();

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  'Delivered',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          );
        },
      ),
      const SizedBox(width: 10),
    ],
  );
}
