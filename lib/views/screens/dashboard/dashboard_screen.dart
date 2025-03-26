import 'package:flutter/material.dart';
import 'package:logistic_driver/services/theme.dart';

import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/screens/dashboard/components/appbar_widget.dart';
import 'package:logistic_driver/views/screens/pakers_and_movers/pakers_and_movers_booking_detail_screen/components/booking_item_widget.dart';

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
                  EarningCardWidget(),
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

class EarningCardWidget extends StatelessWidget {
  const EarningCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Total Orders',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7A7A7A),
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '15',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 0.5,
                color: Colors.grey.shade400,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Total Orders',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7A7A7A),
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '₹ 25000',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade400),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Received',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7A7A7A),
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '₹ 8500',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due Payment',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7A7A7A),
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₹ 16500',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OngoingOrderWidget extends StatelessWidget {
  const OngoingOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const BookingItemWidget();
      },
    );
  }
}

class CompleteOrderWidget extends StatelessWidget {
  const CompleteOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return const BookingItemWidget();
      },
    );
  }
}
