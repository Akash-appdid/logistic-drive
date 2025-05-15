import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';

AppBar localBikeTempoBookingAppBar(BuildContext context) {
  return AppBar(
    title: GetBuilder<LocalBikeTempoController>(builder: (controller) {
      if (controller.isLoading) {
        return const SizedBox.shrink();
      }
      return Text(
        'ID #${(controller.localBikeTempoBookingData?.bookingId ?? '').toUpperCase()}',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      );
    }),
    actions: const [
      SizedBox(width: 10),
    ],
  );
}
