import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/views/screens/dashboard/local_bike_and_tempo/components/localbiketempo_completed_widget.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';
import '../../../base/dialogs/custom_nodata_found.dart';
import '../components/booking_shimmer.dart';
import 'components/local_bike_and_tempo_ongoing_order_widget.dart';

class LocalBikeAndTempoWidget extends StatelessWidget {
  const LocalBikeAndTempoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (bookingCtrl) {
      return GetBuilder<LocalBikeTempoController>(
        builder: (localBikeTempoCtrl) {
          if (localBikeTempoCtrl.isLoading) {
            return const BookingShimmer();
          }
          if (localBikeTempoCtrl.allOrderData.isEmpty) {
            return const CustomNoDataFoundWidget();
          }
          if (bookingCtrl.isOnGoingOrder) {
            return const LocalBikeAndTempoOngoingOrderWidget();
          } else {
            return const LocalBikeTempCompletedWidget();
          }
        },
      );
    });
  }
}
