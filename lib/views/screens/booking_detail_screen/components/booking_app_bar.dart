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
      // GetBuilder<BookingController>(builder: (controller) {
      //   if (controller.isLoading) {
      //     return const SizedBox.shrink();
      //   }
      //   if (controller.bookingsDetailData?.delivered == null) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.end,

      //       children: [
      //         Container(
      //           padding:
      //               const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      //           decoration: BoxDecoration(
      //             borderRadius: const BorderRadius.only(
      //                 bottomLeft: Radius.circular(6),
      //                 topRight: Radius.circular(6)),
      //             color: controller.bookingsDetailData?.status?.toLowerCase() ==
      //                     'intransit'
      //                 ? Colors.orange
      //                 : Colors.green,
      //           ),
      //           child: Center(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Icon(
      //                   controller.bookingsDetailData?.status?.toLowerCase() ==
      //                           'intransit'
      //                       ? Icons.local_shipping
      //                       : Icons.check,
      //                   color: Colors.white,
      //                   size: 16,
      //                 ),
      //                 const SizedBox(width: 6),
      //                 Text(
      //                   controller.bookingsDetailData?.status
      //                           ?.capitalizeFirstOfEach ??
      //                       'NA',
      //                   style: const TextStyle(
      //                     fontSize: 12,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         if (controller.bookingsDetailData?.confirmed == null)
      //           Container(
      //             padding:
      //                 const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      //             decoration: BoxDecoration(
      //               borderRadius: const BorderRadius.only(
      //                 bottomLeft: Radius.circular(6),
      //               ),
      //               color: controller.setStatusOfBooking(
      //                           controller.bookingsDetailData) ==
      //                       'intransit'
      //                   ? Colors.orange
      //                   : Colors.green,
      //             ),
      //             child: Center(
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Icon(
      //                     controller.setStatusOfBooking(
      //                                 controller.bookingsDetailData) ==
      //                             'intransit'
      //                         ? Icons.local_shipping
      //                         : Icons.check,
      //                     color: Colors.white,
      //                     size: 16,
      //                   ),
      //                   const SizedBox(width: 6),
      //                   Text(
      //                     controller
      //                         .setStatusOfBooking(controller.bookingsDetailData)
      //                         .capitalizeFirstOfEach,
      //                     style: const TextStyle(
      //                       fontSize: 12,
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.w600,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //       ],
      //     );
      //   }
      //   return Container(
      //     height: 30,
      //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      //     decoration: BoxDecoration(
      //       color:
      //           controller.setStatusOfBooking(controller.bookingsDetailData) ==
      //                   'intransit'
      //               ? Colors.orange
      //               : Colors.green,
      //       borderRadius: const BorderRadius.only(
      //         topRight: Radius.circular(10),
      //         bottomLeft: Radius.circular(10),
      //       ),
      //     ),
      //     child: Center(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(
      //             controller.setStatusOfBooking(
      //                         controller.bookingsDetailData) ==
      //                     'intransit'
      //                 ? Icons.local_shipping
      //                 : Icons.check,
      //             color: Colors.white,
      //             size: 16,
      //           ),
      //           const SizedBox(width: 6),
      //           Text(
      //             controller
      //                 .setStatusOfBooking(controller.bookingsDetailData)
      //                 .capitalizeFirstOfEach,
      //             style: const TextStyle(
      //               fontSize: 12,
      //               color: Colors.white,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // }),
      const SizedBox(width: 10),
    ],
  );
}
