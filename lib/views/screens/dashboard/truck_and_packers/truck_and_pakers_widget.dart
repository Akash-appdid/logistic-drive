import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../controllers/booking_controller.dart';
import '../../../base/dialogs/custom_nodata_found.dart';
import '../components/booking_shimmer.dart';
import 'components/complete_order_widget.dart';
import 'components/ongoing_order_widget.dart';

class TruckAndPakersWidget extends StatelessWidget {
  const TruckAndPakersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (bookingCtrl) {
      if (bookingCtrl.isLoading) {
        return const BookingShimmer();
      }
      if (bookingCtrl.bookingsData.isEmpty) {
        return const CustomNoDataFoundWidget();
      }
      if (bookingCtrl.isOnGoingOrder) {
        return const OngoingOrderWidget();
      } else {
        return const CompleteOrderWidget();
      }
    });
  }
}
