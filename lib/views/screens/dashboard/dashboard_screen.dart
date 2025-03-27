import 'package:flutter/material.dart';
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
                          color: isOnGoingOrder ? primaryColor : Colors.white,
                          type: isOnGoingOrder ? ButtonType.primary : ButtonType.secondary,
                          onTap: () {
                            isOnGoingOrder = true;
                            setState(() {});
                          },
                          title: 'On Going',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          elevation: 2,
                          radius: 10,
                          color: !isOnGoingOrder ? primaryColor : Colors.white,
                          type: !isOnGoingOrder ? ButtonType.primary : ButtonType.secondary,
                          onTap: () {
                            isOnGoingOrder = false;
                            setState(() {});
                          },
                          title: 'Completed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  isOnGoingOrder ? const OngoingOrderWidget() : const CompleteOrderWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
