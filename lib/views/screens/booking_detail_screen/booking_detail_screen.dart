import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/services/theme.dart';

import 'package:logistic_driver/views/screens/booking_detail_screen/components/booking_app_bar.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/order_tracking_status_widget.dart';
import 'package:logistic_driver/views/screens/home_items_list/home_item_list_screen.dart';

import 'components/booking_button_widget.dart';
import 'components/custom_timeline_widget.dart';
import 'components/delivery_date_and_distance_widget.dart';
import 'components/order_heading_widget.dart';
import 'components/order_status_widget.dart';

import 'components/payment_inforamtion_widget.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key, required this.bookingId});
  final int bookingId;

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      await Get.find<BookingController>()
          .getBookingDetail(id: widget.bookingId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Timer.run(() async {
      final controller = Get.find<BookingController>();
      controller.setIsComplete(true);
      await controller.getAllBooking(isClear: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bookingAppBar(context),
      body: GetBuilder<BookingController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          backgroundColor: backgroundLight,
          onRefresh: () async {
            await Get.find<BookingController>()
                .getBookingDetail(id: widget.bookingId);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const OrderStatusWidget(),
                const OrderHeadingWidget(),
                const CustomTImelineWidget(),
                HomeListButtonWidget(
                  bookingId: widget.bookingId,
                ),
                const OrderTrackingStatusWidget(),
                const DeliveryDateAndDistanceWidget(),
                const PaymentInformationWidget(),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: const BookingButtonWidget(),
    );
  }
}

class HomeListButtonWidget extends StatelessWidget {
  const HomeListButtonWidget({
    super.key,
    required this.bookingId,
  });
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(getCustomRoute(
              child: HomeItemListScreen(
            bookingId: bookingId,
          )));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF09596F),
                Color(0xFF11ABD5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Home Items",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    });
  }
}
