import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/controllers/location_controller.dart';
import 'package:logistic_driver/services/theme.dart';

import 'package:logistic_driver/views/screens/dashboard/components/appbar_widget.dart';

import '../../../controllers/pusher_controller.dart';
import 'components/bookinglist_section_widget.dart';
import 'components/earning_card_widget.dart';
import '../drawer_screens/drawer_screen.dart';
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
    final controller = Get.find<BookingController>();
    final locationCtrl = Get.find<LocationController>();
    final basicCtrl = Get.find<BasicController>();
    locationCtrl.fetchCurrentLocationPlace().then((val) {
      basicCtrl.updateLocation(locationCtrl.updateLocationData());
    });
    await basicCtrl.getAnalyticsData();
    controller.bookingInitMethodForPagination();
    if (controller.isOnGoingOrder) {
      await controller.getAllBooking(isClear: true);
    } else {
      await controller.getAllBooking(status: 'delivered', isClear: true);
    }
    if (Get.find<AuthController>().userModel != null) {
      Get.find<PusherController>().initializePusher(
          driverId: Get.find<AuthController>().userModel?.id ?? 0);
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EarningCardWidget(),
                      SizedBox(height: 15),
                      //-----on off duty------
                      DutyOnOffButtonWidget(),
                      SizedBox(height: 15),
                      OrderWidget(),
                      //--------------Bookings--------------------
                      SizedBox(height: 15),
                      BookingsListSectionWidget(),
                      // GetBuilder<AuthController>(builder: (authController) {
                      //   log('${authController.userModel?.vehicleType}');
                      //   if (authController.userModel?.isMotorbike ?? false) {
                      //     return Column();
                      //   }
                      //   return
                      // })
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

class DutyOnOffButtonWidget extends StatelessWidget {
  const DutyOnOffButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        if ((controller.userModel?.isDuty ?? false)) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.red.shade500,
          ),
          child: Text(
            'You are off duty',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
