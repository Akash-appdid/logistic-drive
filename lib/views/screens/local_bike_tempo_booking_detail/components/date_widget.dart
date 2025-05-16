import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/local_bike_tempo_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../services/theme.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBikeTempoController>(builder: (localBikeTempoCtrl) {
      final data = localBikeTempoCtrl.localBikeTempoBookingData;
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 6),
        width: double.infinity,
        color: primaryColor,
        child: Center(
          child: Text(
            data?.createdAt?.toLocal().dateTime ?? '',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
    });
  }
}
