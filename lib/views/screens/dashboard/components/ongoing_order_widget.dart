import 'package:flutter/material.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/booking_detail_screen.dart';

import '../../booking_detail_screen/components/booking_item_widget.dart';

class OngoingOrderWidget extends StatelessWidget {
  const OngoingOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(getCustomRoute(child: const BookingDetailScreen()));
          },
          child: const BookingItemWidget(),
        );
      },
    );
  }
}
