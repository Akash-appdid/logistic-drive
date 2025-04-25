import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../controllers/booking_controller.dart';
import '../../../../services/route_helper.dart';
import '../../pakers_and_movers/home_item_screen/Home_item_screen.dart';

class HomeListButtonWidget extends StatelessWidget {
  const HomeListButtonWidget({
    super.key,
    required this.bookingId,
  });
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(getCustomRoute(
              child: HomeItemScreen(
            bookingId: bookingId,
          )));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF09596F),
                Color(0xFF11ABD5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Home Items",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    });
  }
}
