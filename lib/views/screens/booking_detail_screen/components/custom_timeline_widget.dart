import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../generated/assets.dart';
import '../../../../services/extra_methods.dart';

class CustomTimelineWidget extends StatefulWidget {
  const CustomTimelineWidget({
    super.key,
  });

  @override
  State<CustomTimelineWidget> createState() => _CustomTimelineWidgetState();
}

class _CustomTimelineWidgetState extends State<CustomTimelineWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      final location = controller.bookingsDetailData?.locations;
      if (location?.isEmpty ?? false) {
        return const SizedBox.shrink();
      }
      return Container(
        // height: ((location?.length ?? 0) * (appSizeHeight * .09)) + 20,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        // child: ReorderableListView.builder(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // onReorder: (oldIndex, newIndex) {
          //   controller.reorderList(oldIndex: oldIndex, newIndex: newIndex);
          // },
          itemCount: location?.length ?? 0,
          itemBuilder: (context, index) {
            bool isLast = index ==
                (controller.bookingsDetailData?.locations?.length ?? 0) - 1;
            double circleSize = 22; //isFirst || isLast ? 40 : 30;
            final status = controller.bookingsDetailData?.locations?[index];

            return Container(
              margin: const EdgeInsets.only(top: 14),
              // height: appSizeHeight * .09,
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
                              //  (status?.getLocationType ?? false)
                              ? const Color(0xFF00C060)
                              : Colors.grey.shade500,
                          // : const Color(0xFFEB0404),
                        ),
                        child: const Icon(
                          // (status?.orderStatus ?? false)`
                          // ?
                          Icons.check,
                          // : Icons.location_on,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      if (!isLast)
                        SizedBox(
                          height: 30,
                          // width: 40,
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
                          "${(status?.type ?? 'NA').capitalizeFirstOfEach} ${status?.getItemIndex}",
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
