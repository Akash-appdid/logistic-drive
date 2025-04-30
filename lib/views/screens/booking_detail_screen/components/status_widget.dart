import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../controllers/booking_controller.dart';
import '../../../../data/models/response/booking_model.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.bookings,
  });

  final BookingsModel bookings;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      if (bookings.status == 'intransit') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    topRight: Radius.circular(6)),
                color: bookings.status?.toLowerCase() == 'intransit'
                    ? Colors.orange
                    : Colors.green,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      bookings.status?.toLowerCase() == 'intransit'
                          ? Icons.local_shipping
                          : Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      bookings.status?.capitalizeFirstOfEach ?? 'NA',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!bookings.isOrderTracking)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                  ),
                  color: controller.setStatusOfBooking(bookings) == 'intransit'
                      ? Colors.orange
                      : Colors.green,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.setStatusOfBooking(bookings) == 'intransit'
                            ? Icons.local_shipping
                            : Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        controller
                            .setStatusOfBooking(bookings)
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
              ),
          ],
        );
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: controller.setStatusOfBooking(bookings) == 'intransit'
              ? Colors.orange
              : Colors.green,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.setStatusOfBooking(bookings) == 'intransit'
                    ? Icons.local_shipping
                    : Icons.check,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                controller.setStatusOfBooking(bookings).capitalizeFirstOfEach,
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
    });
  }
}
