import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../services/theme.dart';

class OrderTrackingStatusWidget extends StatelessWidget {
  const OrderTrackingStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      int pickupCount = 0;
      int dropCount = 0;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Tracking  Status:',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.bookingsDetailData?.locations?.length,
              itemBuilder: (context, index) {
                final data = controller.bookingsDetailData?.locations?[index];
                if (data?.type == 'pickup') {
                  pickupCount++;
                } else if (data?.type == 'drop') {
                  dropCount++;
                }
                if (data?.status != 'done') {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: green,
                                radius: 12,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${data?.type.capitalizeFirstOfEach} ${data?.type == 'pickup' ? pickupCount : dropCount}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (data?.doneAt != null)
                            Text(
                              (data?.doneAt as DateTime).dateTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                            )
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(color: Colors.grey.shade200)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
