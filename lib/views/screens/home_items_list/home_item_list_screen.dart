import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/home_items_list/add_item_screen/add_item_screen.dart';

import 'components/home_item_widget/home_item_widget.dart';

class HomeItemListScreen extends StatelessWidget {
  const HomeItemListScreen({super.key, required this.bookingId});
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
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(getCustomRoute(child: const AddItemScreen()));
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor.withOpacity(.3),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Add Item',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
              ),
            ),
          ),
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
              ListView.separated(
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
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 9,
                    color: Color(0xFFF1F1F1),
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
