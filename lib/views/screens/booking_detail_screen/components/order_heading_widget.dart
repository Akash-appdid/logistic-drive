import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';

import '../../../base/custom_image.dart';

class OrderHeadingWidget extends StatelessWidget {
  const OrderHeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          const CustomImage(
            path: Assets.imagesTruck,
            height: 50,
            fit: BoxFit.cover,
          ),
          //
          const Spacer(),
          GetBuilder<BookingController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.bookingsDetailData?.vehicle?.name ?? 'NA',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff787878),
                      ),
                ),
                Text(
                  controller.bookingsDetailData?.driver?.vehicleNumber ?? 'NA',
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
  }
}
