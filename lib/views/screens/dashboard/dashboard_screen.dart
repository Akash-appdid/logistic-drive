import 'package:flutter/material.dart';
import 'package:logistic_driver/services/theme.dart';

import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/screens/dashboard/components/appbar_widget.dart';

import 'components/location_contaner_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                  Text(
                    'Bookings',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          radius: 10,
                          elevation: 2,
                          onTap: () {},
                          title: 'Upcoming',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          radius: 10,
                          color: Colors.white,
                          type: ButtonType.secondary,
                          elevation: 2,
                          onTap: () {},
                          title: 'Completed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'ID #12351302111',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: primaryColor,
                                      ),
                                ),
                              ),
                              Text(
                                '20 March 2025  11:25 AM',
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor,
                                    ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey.shade200),
                          const LocationContanerWidget(
                            iconColor: Color(0xff00C060),
                            icon: Icons.location_on,
                            label: "From",
                            name: "Kunal Pawar",
                            phone: "+91 89455 53123",
                            address: "Gopi Tank Marg, Mahim West, Shivaji Park...",
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const LocationContanerWidget(
                              iconColor: Color(0xffEB0404),
                              icon: Icons.location_on,
                              label: "To",
                              name: "Manoj Dalavi",
                              phone: "+91 89455 53123",
                              address: "Worli Shivaji Nagar, Worli Mumbai, Maharashtra 400030",
                            ),
                          ),
                          Divider(color: Colors.grey.shade200),
                          Text(
                            'Delivery Date: 25 March 2025',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
