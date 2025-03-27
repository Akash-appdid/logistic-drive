import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import 'package:logistic_driver/services/theme.dart';

import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/screens/dashboard/components/appbar_widget.dart';

import 'components/complete_order_widget.dart';
import 'components/earning_card_widget.dart';
import 'components/ongoing_order_widget.dart';
import '../drawer_screens/drawer_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isOnGoingOrder = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey.shade200),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EarningCardWidget(),
                  //--------------Bookings--------------------
                  const SizedBox(height: 15),
                  BookingsListSectionWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingsListSectionWidget extends StatelessWidget {
  const BookingsListSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicController>(builder: (controller) {
      return Column(
        children: [
          Text(
            'Bookings',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  radius: 10,
                  elevation: 2,
                  color: controller.isOnGoingOrder ? primaryColor : Colors.white,
                  type: controller.isOnGoingOrder ? ButtonType.primary : ButtonType.secondary,
                  onTap: () {
                    controller.setIsComplete(true);
                  },
                  title: 'On Going',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  elevation: 2,
                  radius: 10,
                  color: !controller.isOnGoingOrder ? primaryColor : Colors.white,
                  type: !controller.isOnGoingOrder ? ButtonType.primary : ButtonType.secondary,
                  onTap: () {
                    controller.setIsComplete(false);
                  },
                  title: 'Completed',
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          controller.isOnGoingOrder ? const OngoingOrderWidget() : const CompleteOrderWidget()
        ],
      );
    });
  }
}
