import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/data/models/response/booking_model.dart';
import 'package:logistic_driver/data/models/response/car_and_bike_model.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/booking_detail_screen.dart';
import '../../../../../services/extra_methods.dart';
import '../../../../../services/theme.dart';
import '../../../booking_detail_screen/car_and_bike_detail_screen/car_and_bike_detail_page.dart';
import '../../../booking_detail_screen/components/booking_item_widget.dart';
import '../../../booking_detail_screen/components/status_widget.dart';
import '../../components/location_contaner_widget.dart';

class OngoingOrderWidget extends StatelessWidget {
  const OngoingOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      log("${controller.bookingsData.length}");
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.bookingData.length,
        itemBuilder: (context, index) {
          final booking = controller.bookingData[index];
          if (booking is BookingsModel) {
            return GestureDetector(
              onTap: () {
                if (booking.id == null) return;
                Navigator.of(context).push(getCustomRoute(
                    child: BookingDetailScreen(
                  bookingId: booking.id!,
                )));
              },
              child: BookingItemWidget(bookings: booking),
            );
          } else if (booking is CarAndBikeModel) {
            return GestureDetector(
              onTap: () {
                if (booking.id == null) return;
                Navigator.of(context).push(getCustomRoute(
                    child: CarAndBikeDetailScreen(bookingId: booking.id!)));
              },
              child: CarAndBikeBookingItemWidget(bookings: booking),
            );
          }
          return const SizedBox.shrink();
        },
      );
    });
  }
}

class CarAndBikeBookingItemWidget extends StatelessWidget {
  const CarAndBikeBookingItemWidget({
    super.key,
    this.isComplete = false,
    required this.bookings,
  });
  final bool isComplete;
  final CarAndBikeModel bookings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withValues(alpha: .1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'ID #${(bookings.bookingId ?? '').toUpperCase()}',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
              ),
              StatusWidget(
                  bookings: BookingsModel(
                status: bookings.status,
              )),
            ],
          ),
          Divider(color: Colors.grey.shade200),
          LocationContanerWidget(
            iconColor: const Color(0xff00C060),
            icon: Icons.location_on,
            label: "From",
            name: bookings.pickupUserName ?? "",
            phone: "+91 ${bookings.pickupUserPhone}",
            address: bookings.getPickupAddress,
          ),
          LocationContanerWidget(
            iconColor: const Color(0xffEB0404),
            icon: Icons.location_on,
            label: 'To',
            name: bookings.dropUserName ?? "",
            phone: "+91 ${bookings.dropUserPhone}",
            address: bookings.getDropAddress,
          ),
          Divider(color: Colors.grey.shade200),
          Row(
            children: [
              // if (bookings != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatSentence(
                          (bookings.bookingType ?? '').capitalizeFirstOfEach),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                    ),
                    Text(
                      'Delivery Date: ${(bookings.estimatedDeliveryDate?.toLocal() as DateTime).dMy}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(radius: 5, backgroundColor: green),
                  const SizedBox(width: 6),
                  Text(
                    formatSentence(bookings.deliveryStatus ?? 'NA')
                        .capitalizeFirstOfEach,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
