import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../services/theme.dart';

class DeliveryDateAndDistanceWidget extends StatelessWidget {
  const DeliveryDateAndDistanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GetBuilder<BookingController>(builder: (controller) {
        final data = controller.bookingsDetailData;

        if (data?.delivered != null) {
          return CustomTitleAndValueWidget(
            title: 'Delivered Date',
            value: (data?.delivered as DateTime).dMy,
          );
        }

        return Column(
          children: [
            Row(
              children: [
                if (data?.estimatedDeliveryDate != null)
                  Expanded(
                    child: CustomTitleAndValueWidget(
                      title: 'Est.Delivery Date',
                      value: (data?.estimatedDeliveryDate as DateTime).dMy,
                    ),
                  ),
                // SizedBox(width: 20),
                // Expanded(
                //   child: CustomTitleAndValueWidget(
                //     title: 'Distance',
                //     value: '25 KM',
                //   ),
                // ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class CustomTitleAndValueWidget extends StatelessWidget {
  const CustomTitleAndValueWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: backgroundDark.withOpacity(.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 15,
                  color: const Color(0xFF8A8A8A),
                ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
          ),
        ],
      ),
    );
  }
}
