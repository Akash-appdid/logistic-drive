import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/constants.dart';
import 'package:logistic_driver/services/extensions.dart';

class CustomTImelineWidget extends StatefulWidget {
  const CustomTImelineWidget({
    super.key,
  });

  @override
  State<CustomTImelineWidget> createState() => _CustomTImelineWidgetState();
}

class _CustomTImelineWidgetState extends State<CustomTImelineWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      int pickupCount = 0;
      int dropCount = 0;
      final location = controller.bookingsDetailData?.locations;
      if (location?.isEmpty ?? false) {
        return const SizedBox.shrink();
      }
      return Container(
        height: ((location?.length ?? 0) * (appSizeHeight * .09)) + 40,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: (oldIndex, newIndex) {
            controller.reorderList(oldIndex: oldIndex, newIndex: newIndex);
          },
          itemCount: location?.length ?? 0,
          itemBuilder: (context, index) {
            // bool isFirst = index == 0;
            bool isLast = index ==
                (controller.bookingsDetailData?.locations?.length ?? 0) - 1;
            double circleSize = 30; //isFirst || isLast ? 40 : 30;
            final status = controller.bookingsDetailData?.locations?[index];
            if (status?.type == 'pickup') {
              pickupCount++;
            } else if (status?.type == 'drop') {
              dropCount++;
            }
            return Container(
              height: appSizeHeight * .09,
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
                          color: (status?.getLocationType ?? false)
                              ? const Color(0xFF00C060)
                              : const Color(0xFFEB0404),
                        ),
                        child: Icon(
                          status?.status == 'done'
                              ? Icons.check
                              : Icons.location_on,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      if (!isLast)
                        SizedBox(
                          height: 30,
                          // width: 40,
                          child: DottedBorder(
                            strokeWidth: 2,
                            dashPattern: const [5, 5],
                            color: Colors.black.withOpacity(0.7),
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
                          "${(status?.type ?? 'NA').capitalizeFirstOfEach} ${status?.type == 'pickup' ? pickupCount : dropCount}",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF787878),
                                  ),
                        ),
                        Text(
                          status?.getAddress ?? '',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
