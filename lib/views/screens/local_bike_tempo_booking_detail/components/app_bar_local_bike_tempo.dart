import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/theme.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';

AppBar localBikeTempoBookingAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Booking detail",
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
    ),
    actions: [
      GetBuilder<LocalBikeTempoController>(builder: (controller) {
        if (controller.isLoading) {
          return const SizedBox.shrink();
        }
        return Text(
          'ID #${(controller.localBikeTempoBookingData?.bookingId ?? '').toUpperCase()}',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 16, fontWeight: FontWeight.w800, color: primaryColor),
        );
      }),
      const SizedBox(width: 10),
    ],
  );
}
