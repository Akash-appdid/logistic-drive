import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/theme.dart';

import 'package:logistic_driver/views/screens/dashboard/components/appbar_widget.dart';

import 'components/bookinglist_section_widget.dart';
import 'components/earning_card_widget.dart';
import '../drawer_screens/drawer_screen.dart';

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
    controller.bookingInitMethodForPagination();
    await controller.getAllBooking(isClear: true);
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
                  controller: controller.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EarningCardWidget(),
                      //--------------Bookings--------------------
                      SizedBox(height: 15),
                      BookingsListSectionWidget()
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
