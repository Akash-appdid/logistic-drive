import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/controllers/local_bike_tempo_controller.dart';
import 'package:logistic_driver/controllers/location_controller.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/dashboard/components/appbar_widget.dart';

import '../../../controllers/pusher_controller.dart';
import '../drawer_screens/drawer_screen.dart';
import 'components/bookinglist_section_widget.dart';
import 'components/dutyonoff_button_widget.dart';
import 'components/earning_card_widget.dart';
import 'components/order_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      init();
    });
  }

  void init() async {
    final authCtrl = Get.find<AuthController>();
    final locationCtrl = Get.find<LocationController>();
    final basicCtrl = Get.find<BasicController>();

    ///------location

    locationCtrl.fetchCurrentLocationPlace().then((val) {
      basicCtrl.updateLocation(locationCtrl.updateLocationData());
    });

    basicCtrl.initsendinglocation();

    ///------pusher
    if (authCtrl.userModel != null) {
      Get.find<PusherController>().initializePusher(driverId: Get.find<AuthController>().userModel?.id ?? 0);
    }

    ///--------analytics

    ///
    if (authCtrl.userModel?.isMotorbike ?? false) {
      await basicCtrl.getBikeTempoAnalyticsData();
      localBikeAndTempoCallingInInit();
    } else {
      await basicCtrl.getAnalyticsData();
      truckAndPackersDataCallingInInti();
    }
  }

  void truckAndPackersDataCallingInInti() async {
    final controller = Get.find<BookingController>();
    controller.bookingInitMethodForPagination();
    if (controller.isOnGoingOrder) {
      await controller.getAllBooking(isClear: true);
    } else {
      await controller.getAllBooking(status: 'delivered', isClear: true);
    }
  }

  void localBikeAndTempoCallingInInit() async {
    final controller = Get.find<BookingController>();
    final orderController = Get.find<LocalBikeTempoController>();
    orderController.bookingInitMethodForPagination(isOnGoingOrder: controller.isOnGoingOrder, scrollController: controller.scrollController);
    if (controller.isOnGoingOrder) {
      await orderController.getAllOrder(isClear: true);
    } else {
      await orderController.getAllOrder(status: 'delivered', isClear: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey.shade200),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: backgroundLight,
              onRefresh: () async {
                init();
              },
              child: GetBuilder<BookingController>(builder: (controller) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Platform.isAndroid
                          ? Get.find<BasicController>().getBusinessSettingValue("production_mode_android_for_driver") == "0"
                          : Get.find<BasicController>().getBusinessSettingValue("production_mode_ios_for_driver") == "0")
                        EarningCardWidget(),
                      SizedBox(height: 15),
                      //-----on off duty------
                      DutyOnOffButtonWidget(),
                      SizedBox(height: 15),
                      OrderWidget(),
                      //--------------Bookings--------------------
                      SizedBox(height: 15),
                      BookingsListSectionWidget(),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
