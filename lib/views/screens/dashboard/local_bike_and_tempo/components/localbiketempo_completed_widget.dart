import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/local_bike_tempo_controller.dart';

import '../../../../../services/route_helper.dart';

import '../../../local_bike_tempo_booking_detail/local_bike_tempo_booking_detail_screen.dart';
import 'localbiketempo_item_widget.dart';

class LocalBikeTempCompletedWidget extends StatelessWidget {
  const LocalBikeTempCompletedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBikeTempoController>(builder: (localBikeTempoCtrl) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: localBikeTempoCtrl.allOrderData.length,
        itemBuilder: (context, index) {
          final booking = localBikeTempoCtrl.allOrderData[index];
          return GestureDetector(
            onTap: () {
              if (booking.id == null) return;
              Navigator.of(context).push(getCustomRoute(
                  child: LocalBikeTempoBookingDetailScreen(
                bookingId: booking.id!,
              )));
            },
            child: LocalBikeAndTempoItemWidget(bookings: booking),
          );
        },
      );
    });
  }
}
