import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../services/extra_methods.dart';
import '../../../base/common_button.dart';

import 'verify_pickup_sheet.dart';

class BookingButtonWidget extends StatelessWidget {
  const BookingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      if (controller.isLoading) {
        return const SizedBox.shrink();
      }
      if (controller.bookingsDetailData?.intransit == null) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                color: const Color(0xFF0F8000),
                onTap: () {
                  showModalBottomSheet(
                    enableDrag: false,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return VerifyPickUpSheet(
                        orderId: controller.bookingsDetailData?.id,
                      );
                    },
                  );
                },
                title: 'Start Trip',
              ),
            )
          ],
        );
      }
      if (controller.isDelivered() &&
          controller.bookingsDetailData?.delivered == null) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                color: const Color(0xFF0F8000),
                onTap: () {
                  controller
                      .endBookingTrip(
                          id: controller.bookingsDetailData?.id ?? 0)
                      .then((value) {
                    if (value.isSuccess) {
                      controller.getBookingDetail(
                          id: controller.bookingsDetailData?.id ?? 0);
                    } else {
                      Fluttertoast.showToast(msg: value.message);
                    }
                  });
                },
                title: 'Mark as Delivered',
              ),
            )
          ],
        );
      }
      if (controller.bookingsDetailData?.delivered != null) {
        return const SizedBox.shrink();
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              color: const Color(0xFF0F8000),
              onTap: () {
                ExtraMethods.drawGoogleRoute(
                    lat: double.parse(controller
                            .bookingsDetailData?.locations?.first.latitude ??
                        '0'),
                    long: double.parse(controller
                            .bookingsDetailData?.locations?.first.longitude ??
                        '0'));
              },
              title:
                  'Navigate to ${controller.selectedLocation?.type.capitalizeFirstOfEach} ${controller.selectedLocation?.type == 'pickup' ? controller.pickupCount : controller.dropCount}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton(
              color: const Color(0xFF0F8000),
              onTap: () {
                controller
                    .loactionMarkAsDone(
                        id: controller.selectedLocation?.id ?? 0)
                    .then((value) {
                  if (value.isSuccess) {
                    controller.getBookingDetail(
                        id: controller.bookingsDetailData?.id ?? 0);
                  } else {
                    Fluttertoast.showToast(msg: value.message);
                  }
                });
              },
              title:
                  '${controller.selectedLocation?.type.capitalizeFirstOfEach} ${controller.selectedLocation?.type == 'pickup' ? controller.pickupCount : controller.dropCount} is done',
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
