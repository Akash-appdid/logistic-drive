import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logistic_driver/services/route_helper.dart';

import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/screens/pakers_and_movers/pakers_and_movers_booking_detail_screen/pakers_and_movers_booking_detail_screen.dart';

import 'pakers_and_movers_booking_detail_screen/components/booking_item_widget.dart';

class PakersAndMoversScreen extends StatelessWidget {
  const PakersAndMoversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            //---------------
            ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    log("pakers");
                    Navigator.of(context).push(getCustomRoute(child: const PakersAndMoversBookingDetailScreen()));
                  },
                  child: const BookingItemWidget(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
