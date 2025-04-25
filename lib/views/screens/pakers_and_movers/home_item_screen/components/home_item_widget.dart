import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';

import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/route_helper.dart';

import 'package:page_transition/page_transition.dart';

import '../../../../../data/models/response/booking_model.dart';
import '../../../../base/common_button.dart';
import '../../home_edit_item_screen/home_edit_item_screen.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    super.key,
    this.homeItem,
    required this.bookingId,
  });
  final List<BookingGoodHomeItem>? homeItem;
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                (homeItem?.first.getHomeDatCategoryTitle ?? 'NA')
                    .capitalizeFirstOfEach,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
              ),
              const Spacer(),
              GetBuilder<BookingController>(builder: (controller) {
                if (controller.bookingsDetailData?.intransit != null) {
                  return const SizedBox.shrink();
                }
                return CustomButton(
                  height: 32,
                  onTap: () {
                    Navigator.of(context).push(
                      getCustomRoute(
                        child: HomeEditItemScreen(
                          homeItem: homeItem,
                          bookingId: bookingId,
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Edit',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
          Divider(color: Colors.grey.shade100),
          GetBuilder<BookingController>(builder: (controller) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeItem?.length,
              itemBuilder: (context, index) {
                final item = homeItem?[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item?.homeItemData?.title ?? 'NA',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Text(
                        '~${item?.quantity} items',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
