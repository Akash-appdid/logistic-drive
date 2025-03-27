import 'package:flutter/material.dart';

import '../../../../services/route_helper.dart';
import '../../../base/common_button.dart';
import '../../pickup_location_screen/pikup_location_screen.dart';

class BookingButtonWidget extends StatelessWidget {
  const BookingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(
            color: const Color(0xFF0F8000),
            onTap: () {
              Navigator.of(context).push(getCustomRoute(child: const PikupLocationScreen()));
            },
            title: 'Go to the pickup location',
          ),
        )
      ],
    );
  }
}
