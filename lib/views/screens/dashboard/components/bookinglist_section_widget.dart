import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/views/base/dialogs/custom_nodata_found.dart';
import 'package:logistic_driver/views/screens/dashboard/components/booking_shimmer.dart';

import '../../../../services/theme.dart';
import '../../../base/common_button.dart';
import 'complete_order_widget.dart';
import 'ongoing_order_widget.dart';

class BookingsListSectionWidget extends StatelessWidget {
  const BookingsListSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bookings',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  radius: 10,
                  elevation: 2,
                  color:
                      controller.isOnGoingOrder ? primaryColor : Colors.white,
                  type: controller.isOnGoingOrder
                      ? ButtonType.primary
                      : ButtonType.secondary,
                  onTap: () {
                    controller.setIsComplete(true);
                    if (controller.isOnGoingOrder) {
                      controller.getAllBooking(isClear: true);
                    }
                  },
                  title: 'On Going',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  elevation: 2,
                  radius: 10,
                  color:
                      !controller.isOnGoingOrder ? primaryColor : Colors.white,
                  type: !controller.isOnGoingOrder
                      ? ButtonType.primary
                      : ButtonType.secondary,
                  onTap: () {
                    controller.setIsComplete(false);
                    if (!controller.isOnGoingOrder) {
                      controller.getAllBooking(
                          status: 'delivered', isClear: true);
                    }
                  },
                  title: 'Completed',
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          GetBuilder<BookingController>(builder: (bookingController) {
            if (bookingController.isLoading) {
              return const BookingShimmer();
            }
            if (bookingController.bookingsData.isEmpty) {
              return const CustomNoDataFoundWidget();
            }

            if (controller.isOnGoingOrder) {
              return const OngoingOrderWidget();
            } else {
              return const CompleteOrderWidget();
            }
          })
        ],
      );
    });
  }
}
