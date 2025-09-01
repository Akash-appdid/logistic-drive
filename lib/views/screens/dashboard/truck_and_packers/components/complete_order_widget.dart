import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/dashboard/truck_and_packers/components/ongoing_order_widget.dart';
import '../../../../../controllers/booking_controller.dart';
import '../../../../../services/route_helper.dart';
import '../../../../base/dialogs/custom_nodata_found.dart';
import '../../../booking_detail_screen/booking_detail_screen.dart';
import '../../../booking_detail_screen/components/booking_item_widget.dart';

class CompleteOrderWidget extends StatelessWidget {
  const CompleteOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return Column(
        children: [
          Divider(color: Colors.grey.shade400),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabWidget(
                name: 'Goods',
                onTap: () {
                  controller.initPagination();
                  controller.handlecompleteOrdersTab(CompleteOrderType.goods);
                  controller.getAllBooking(status: 'delivered', isClear: true);
                },
                isActive: controller.selectedTab == CompleteOrderType.goods,
              ),
              TabWidget(
                name: 'Packers and movers',
                onTap: () {
                  controller.initPagination();
                  controller.handlecompleteOrdersTab(
                      CompleteOrderType.packersAndMovers);
                  controller.getAllBooking(status: 'delivered', isClear: true);
                },
                isActive: controller.selectedTab ==
                    CompleteOrderType.packersAndMovers,
              ),
              TabWidget(
                name: 'Car and bike',
                onTap: () {
                  controller.initPagination();
                  controller.carBikeBookingData.clear();
                  controller.update();
                  controller
                      .handlecompleteOrdersTab(CompleteOrderType.carAndBike);
                  controller.getAllCarandBikesBooking(
                      status: 'delivered', isClear: true);
                },
                isActive:
                    controller.selectedTab == CompleteOrderType.carAndBike,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Builder(builder: (_) {
            if (controller.selectedTab == CompleteOrderType.carAndBike) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.carBikeBookingData.length,
                itemBuilder: (context, index) {
                  final booking = controller.carBikeBookingData[index];
                  return GestureDetector(
                    onTap: () {
                      if (booking.id == null) return;
                      Navigator.of(context).push(getCustomRoute(
                          child: BookingDetailScreen(
                        bookingId: booking.id!,
                      )));
                    },
                    child: CarAndBikeBookingItemWidget(
                      bookings: booking,
                    ),
                  );
                },
              );
            }
            if (controller.bookingsData.isEmpty) {
              return const CustomNoDataFoundWidget();
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.bookingsData.length,
              itemBuilder: (context, index) {
                final booking = controller.bookingsData[index];
                return GestureDetector(
                  onTap: () {
                    if (booking.id == null) return;
                    Navigator.of(context).push(getCustomRoute(
                        child: BookingDetailScreen(
                      bookingId: booking.id!,
                    )));
                  },
                  child: BookingItemWidget(
                    bookings: booking,
                  ),
                );
              },
            );
          }),
        ],
      );
    });
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.name,
    this.onTap,
    required this.isActive,
  });
  final String name;
  final Function()? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 4),
              color: Colors.black.withValues(alpha: 0.25),
            )
          ],
        ),
        child: Text(
          name,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : null,
              ),
        ),
      ),
    );
  }
}
