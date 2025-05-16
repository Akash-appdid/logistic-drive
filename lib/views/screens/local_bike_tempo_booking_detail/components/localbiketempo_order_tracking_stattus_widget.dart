import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';
import '../../../../services/theme.dart';

class OrderTrackingStatusWidgetOfLocalBikeTempo extends StatelessWidget {
  const OrderTrackingStatusWidgetOfLocalBikeTempo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBikeTempoController>(builder: (controller) {
      if (controller.localBikeTempoBookingData?.isOrderTracking ?? true) {
        return const SizedBox.shrink();
      }
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.grey.shade200,
            )),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Tracking  Status',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  controller.localBikeTempoBookingData?.locations?.length,
              itemBuilder: (context, index) {
                final data =
                    controller.localBikeTempoBookingData?.locations?[index];

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
                                '${data?.type.capitalizeFirstOfEach} ${data?.getItemIndex}',
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
                              (data?.doneAt)?.dateTime ?? 'NA',
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
