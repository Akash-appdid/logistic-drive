import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/booking_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../../services/extra_methods.dart';

class CustomTimelineWidgetForCarAndBike extends StatefulWidget {
  const CustomTimelineWidgetForCarAndBike({
    super.key,
  });

  @override
  State<CustomTimelineWidgetForCarAndBike> createState() =>
      _CustomTimelineWidgetForCarAndBikeState();
}

class _CustomTimelineWidgetForCarAndBikeState
    extends State<CustomTimelineWidgetForCarAndBike> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      final location = controller.carAndBokingDetailData;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 14),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (location?.pickupDoneAt != null)
                              ? const Color(0xFF00C060)
                              : Colors.grey.shade500,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: DottedBorder(
                          strokeWidth: 2,
                          dashPattern: const [5, 5],
                          color: (location?.pickupDoneAt != null)
                              ? Colors.black.withValues(alpha: 0.7)
                              : Colors.grey.shade600,
                          customPath: (size) {
                            return Path()
                              ..moveTo(size.width / 2, 8)
                              ..lineTo(size.width / 2, 50);
                          },
                          child: const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pickup",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: location?.pickupDoneAt != null
                                      ? Colors.green
                                      : const Color(0xFF787878)),
                        ),
                        Text(
                          location?.getPickupAddress ?? '',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: location?.pickupDoneAt != null
                                        ? Colors.black
                                        : const Color(0xFF787878),
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ExtraMethods.drawGoogleRoute(
                          lat: double.parse(location?.pickupLatitude ?? '0'),
                          long: double.parse(location?.pickupLongitude ?? '0'));
                    },
                    icon: SvgPicture.asset(
                      Assets.svgsRoute,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 14),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (location?.dropDoneAt != null)
                              ? const Color(0xFF00C060)
                              : Colors.grey.shade500,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Drop",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: location?.dropDoneAt != null
                                        ? Colors.red
                                        : const Color(0xFF787878),
                                  ),
                        ),
                        Text(
                          location?.getDropAddress ?? '',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: location?.dropDoneAt != null
                                        ? Colors.black
                                        : const Color(0xFF787878),
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ExtraMethods.drawGoogleRoute(
                          lat: double.parse(location?.dropLatitude ?? '0'),
                          long: double.parse(location?.dropLongitude ?? '0'));
                    },
                    icon: SvgPicture.asset(
                      Assets.svgsRoute,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
