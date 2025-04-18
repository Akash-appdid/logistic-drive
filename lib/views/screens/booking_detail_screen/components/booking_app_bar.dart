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
    actions: [
      // GetBuilder(
      //   builder: (context) {
      //     return Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //       decoration: BoxDecoration(
      //         color: primaryColor,
      //         borderRadius: BorderRadius.circular(50),
      //       ),
      //       child: Row(
      //         children: [
      //           Text(
      //             'Support',
      //             style: Theme.of(context).textTheme.labelMedium!.copyWith(
      //                   fontSize: 14,
      //                   fontWeight: FontWeight.w600,
      //                   color: Colors.white,
      //                 ),
      //           ),
      //           const SizedBox(width: 8),
      //           const Icon(
      //             Icons.headphones,
      //             size: 17,
      //           ),
      //         ],
      //       ),
      //     );
      //   }
      // ),
      const SizedBox(width: 10),
    ],
  );
}
