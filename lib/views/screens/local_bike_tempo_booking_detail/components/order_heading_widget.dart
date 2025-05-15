import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/local_bike_tempo_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            const CustomImage(
              path: Assets.imagesDeliveryBike,
              height: 50,
              fit: BoxFit.cover,
            ),
            //
            const Spacer(),
            GetBuilder<LocalBikeTempoController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.localBikeTempoBookingData?.driver?.vehicleType
                            .capitalizeFirstOfEach ??
                        'NA',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff787878),
                        ),
                  ),
                  Text(
                    controller
                            .localBikeTempoBookingData?.driver?.vehicleNumber ??
                        'NA',
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
