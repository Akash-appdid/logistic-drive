import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';
import '../../../../generated/assets.dart';
import '../../../../services/extra_methods.dart';

class CustomTimelineWidgetOfLocalBikeTempo extends StatefulWidget {
  const CustomTimelineWidgetOfLocalBikeTempo({
    super.key,
  });

  @override
  State<CustomTimelineWidgetOfLocalBikeTempo> createState() =>
      _LocalBikeTempoCustomTimelineWidgetOfLocalBikeTempoState();
}

class _LocalBikeTempoCustomTimelineWidgetOfLocalBikeTempoState
    extends State<CustomTimelineWidgetOfLocalBikeTempo> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBikeTempoController>(builder: (controller) {
      final location = controller.localBikeTempoBookingData?.locations;
      log("${location?.isEmpty}");
      if (location?.isEmpty ?? false) {
        return const SizedBox.shrink();
      }
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: location?.length ?? 0,
          itemBuilder: (context, index) {
            bool isLast = index ==
                (controller.localBikeTempoBookingData?.locations?.length ?? 0) -
                    1;
            double circleSize = 22;
            final status =
                controller.localBikeTempoBookingData?.locations?[index];

            return Container(
              margin: const EdgeInsets.only(top: 14),
              key: ValueKey(status?.id),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (status?.orderStatus ?? false)
                              ? const Color(0xFF00C060)
                              : Colors.grey.shade500,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      if (!isLast)
                        SizedBox(
                          height: 30,
                          child: DottedBorder(
                            strokeWidth: 2,
                            dashPattern: const [5, 5],
                            color: (status?.orderStatus ?? false)
                                ? Colors.black.withOpacity(0.7)
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
                          "${(status?.type ?? 'NA').capitalizeFirstOfEach} ${status?.getItemIndex}", // ${status?.getItemIndex}",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: (status?.orderStatus ?? false)
                                        ? status?.type == 'pickup'
                                            ? Colors.green
                                            : Colors.red
                                        : const Color(0xFF787878),
                                  ),
                        ),
                        Text(
                          status?.getAddress ?? '',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: (status?.orderStatus ?? false)
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
                          lat: double.parse(status?.latitude ?? '0'),
                          long: double.parse(status?.longitude ?? '0'));
                    },
                    icon: SvgPicture.asset(
                      Assets.svgsRoute,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
