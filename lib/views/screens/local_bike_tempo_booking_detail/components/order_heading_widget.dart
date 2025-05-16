import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/local_bike_tempo_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/theme.dart';

import '../../../base/custom_image.dart';

class OrderHeadingWidgetOfLocalBikeTempo extends StatelessWidget {
  const OrderHeadingWidgetOfLocalBikeTempo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBikeTempoController>(builder: (controller) {
      if (controller.localBikeTempoBookingData?.bookingType ==
          'packers_and_movers') {
        return const SizedBox.shrink();
      }
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CustomImage(
                  path: Assets.imagesDeliveryBike,
                  height: 30,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey.shade200,
                ),
                Text('')
              ],
            ),
            // const SizedBox(height: 8),
            Divider(color: Colors.grey.shade200),

            GetBuilder<LocalBikeTempoController>(builder: (controller) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.localBikeTempoBookingData?.driver?.vehicleType
                            .capitalizeFirstOfEach ??
                        'NA',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff252525),
                        ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    controller
                            .localBikeTempoBookingData?.driver?.vehicleNumber ??
                        'NA',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          // color: const Color(0xff252525),
                          color: primaryColor,
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
