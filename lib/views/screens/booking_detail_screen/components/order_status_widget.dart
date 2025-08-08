import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extra_methods.dart';

import '../../../../generated/assets.dart';
import '../../../../services/theme.dart';
import '../../../base/custom_horizontal_line.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: formatSentence(
                      controller.bookingsDetailData?.deliveryStatus ?? 'NA') ==
                  'delay'
              ? Colors.red
              : primaryColor, //Color(0xFF0F8000),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(
                    width: 200,
                    child: CustomHorizontalDottendLine(),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    Assets.svgsTruck,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            Text(
              formatSentence(
                  controller.bookingsDetailData?.deliveryStatus ?? 'NA'),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      );
    });
  }
}
