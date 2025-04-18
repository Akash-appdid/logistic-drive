import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/booking_controller.dart';
import '../../../../services/route_helper.dart';
import '../../booking_detail_screen/booking_detail_screen.dart';
import '../../booking_detail_screen/components/booking_item_widget.dart';

class CompleteOrderWidget extends StatelessWidget {
  const CompleteOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.bookingsData.length,
        itemBuilder: (context, index) {
          final booking = controller.bookingsData[index];
          return GestureDetector(
            onTap: () {
              if (booking.id == null) return;
              Navigator.of(context).push(getCustomRoute(
                  child: BookingDetailScreen(
                bookingId: booking.id!,
              )));
            },
            child: BookingItemWidget(
              bookings: booking,
            ),
          );
        },
      );
    });
  }
}
