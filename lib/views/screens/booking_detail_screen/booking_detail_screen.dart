import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/theme.dart';

import 'package:logistic_driver/views/screens/booking_detail_screen/components/booking_app_bar.dart';

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

      Get.find<BookingController>().selectLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Timer.run(() async {
      final controller = Get.find<BookingController>();
      controller.getAllBooking(isClear: true);
      controller.bookingInitMethodForPagination();
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
            child: Column(
              children: [
                const OrderStatusWidget(),
                const OrderHeadingWidget(),
                const CustomTImelineWidget(),
                Divider(color: Colors.grey.shade200, thickness: 10),
                // const OrderTrackingStatusWidget(),
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
