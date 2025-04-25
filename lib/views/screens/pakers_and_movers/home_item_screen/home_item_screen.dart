import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/pakers_and_movers/home_item_screen/components/home_item_widget.dart';
import '../add_item_screen/add_item_screen.dart';

class HomeItemScreen extends StatelessWidget {
  const HomeItemScreen({super.key, required this.bookingId});
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Items',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          GetBuilder<BookingController>(builder: (controller) {
            if (controller.bookingsDetailData?.intransit != null) {
              return const SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(getCustomRoute(child: const AddItemScreen()));
              },
              child: Container(
                height: 32,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Add Item',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(width: 10),
        ],
      ),
      body: GetBuilder<BookingController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    controller.bookingsDetailData?.getHomeItemList.length ?? 0,
                itemBuilder: (context, index) {
                  final homeItem =
                      controller.bookingsDetailData?.getHomeItemList[index];

                  return HomeItemWidget(
                    bookingId: bookingId,
                    homeItem: homeItem,
                  );
                },
              )
              //
            ],
          ),
        );
      }),
    );
  }
}
