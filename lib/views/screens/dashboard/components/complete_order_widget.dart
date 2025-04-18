import 'package:flutter/material.dart';
import 'package:logistic_driver/data/models/response/booking_model.dart';

import '../../booking_detail_screen/components/booking_item_widget.dart';

class CompleteOrderWidget extends StatelessWidget {
  const CompleteOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return BookingItemWidget(
          isComplete: true,
          bookings: BookingsModel(),
        );
      },
    );
  }
}
