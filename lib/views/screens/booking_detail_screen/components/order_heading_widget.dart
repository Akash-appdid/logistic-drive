import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';

import '../../../base/custom_image.dart';

class OrderHeadingWidget extends StatelessWidget {
  const OrderHeadingWidget({
    super.key,
    required this.type,
    required this.vehicleNumber,
    required this.vehicalName,
  });
  final String type;
  final String vehicleNumber;
  final String vehicalName;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      if (type == 'packers_and_movers') {
        return const SizedBox.shrink();
      }
      return Container(
        color: const Color(0xFFF5F5F5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            // const CustomImage(
            //   path: Assets.imagesTruck,
            //   height: 50,
            //   fit: BoxFit.cover,
            // ),
            //
            // const Spacer(),
            GetBuilder<BookingController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicalName,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff787878),
                        ),
                  ),
                  Text(
                    vehicleNumber,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff252525),
                        ),
                  )
                ],
              );
            })
          ],
        ),
      );
    });
  }
}
