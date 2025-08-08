import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/booking_app_bar.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/order_tracking_status_widget.dart';
import 'components/booking_button_widget.dart';
import 'components/custom_timeline_widget.dart';
import 'components/delivery_date_and_distance_widget.dart';
import 'components/home_list_button_widget.dart';
import 'components/order_heading_widget.dart';
import 'components/order_status_widget.dart';
import 'components/payment_inforamtion_widget.dart';
import 'components/upload_epod_widget.dart';

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
                OrderHeadingWidget(
                  type: controller.bookingsDetailData?.bookingType ?? '',
                  vehicleNumber:
                      controller.bookingsDetailData?.vehicle?.name ?? '',
                  vehicalName:
                      controller.bookingsDetailData?.driver?.vehicleNumber ??
                          '',
                ),
                const CustomTimelineWidget(),
                HomeListButtonWidget(bookingId: widget.bookingId),
                const OrderTrackingStatusWidget(),
                const DeliveryDateAndDistanceWidget(),
                const PaymentInformationWidget(),
                const SizedBox(height: 10),
                UploadEpodWidget(bookingId: widget.bookingId),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: const BookingButtonWidget(),
    );
  }
}
