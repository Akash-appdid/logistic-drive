import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/booking_controller.dart';
import '../../../controllers/local_bike_tempo_controller.dart';
import '../../../services/theme.dart';

import 'components/app_bar_local_bike_tempo.dart';
import 'components/booking_button_widget_of_bike_tempo.dart';
import 'components/local_bike_tempo_custom_timeline_widget.dart';
import 'components/localbiketempo_order_tracking_stattus_widget.dart';
import 'components/order_heading_widget.dart';
import 'components/payment_inforamtion_widget.dart';

class LocalBikeTempoBookingDetailScreen extends StatefulWidget {
  final int bookingId;
  const LocalBikeTempoBookingDetailScreen({super.key, required this.bookingId});

  @override
  State<LocalBikeTempoBookingDetailScreen> createState() =>
      _LocalBikeTempoBookingDetailScreenState();
}

class _LocalBikeTempoBookingDetailScreenState
    extends State<LocalBikeTempoBookingDetailScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      init();
    });
  }

  void init() async {
    final authCtrl = Get.find<AuthController>();
    final bookingCtrl = Get.find<BookingController>();
    final localBikeTempCtrl = Get.find<LocalBikeTempoController>();
    if (authCtrl.userModel?.isMotorbike ?? false) {
      localBikeTempCtrl.getLocalBikeTempBookingDetailData(id: widget.bookingId);
    } else {
      await bookingCtrl.getBookingDetail(id: widget.bookingId);
    }
  }

  @override
  void dispose() {
    super.dispose();
    Timer.run(() async {
      final authCtrl = Get.find<AuthController>();
      final bookingCtrl = Get.find<BookingController>();
      final localBikeTempCtrl = Get.find<LocalBikeTempoController>();
      bookingCtrl.setIsComplete(true);
      if (authCtrl.userModel?.isMotorbike ?? false) {
        localBikeTempCtrl.getAllOrder(isClear: true);
      } else {
        await bookingCtrl.getAllBooking(isClear: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: localBikeTempoBookingAppBar(context),
      body: GetBuilder<LocalBikeTempoController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          backgroundColor: backgroundLight,
          onRefresh: () async {
            await Get.find<LocalBikeTempoController>()
                .getLocalBikeTempBookingDetailData(id: widget.bookingId);
          },
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // const LocalBikeTempoOrderStatusWidget(),
                OrderHeadingWidgetOfLocalBikeTempo(),
                CustomTimelineWidgetOfLocalBikeTempo(),
                OrderTrackingStatusWidgetOfLocalBikeTempo(),
                PaymentInformationWidgetOfLocalBikeTempo(),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: const BookingButtonWidgetOfBikeTempo(),
    );
  }
}
