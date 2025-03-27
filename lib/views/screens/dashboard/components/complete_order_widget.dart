import 'package:flutter/material.dart';

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
        return const BookingItemWidget(
          isComplete: true,
        );
      },
    );
  }
}
