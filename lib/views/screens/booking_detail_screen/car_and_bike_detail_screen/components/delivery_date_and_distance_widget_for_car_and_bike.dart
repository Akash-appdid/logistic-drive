import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/delivery_date_and_distance_widget.dart';

class DeliveryDateAndDistanceWidgetForCarAndBike extends StatelessWidget {
  const DeliveryDateAndDistanceWidgetForCarAndBike({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GetBuilder<BookingController>(builder: (controller) {
        final data = controller.carAndBokingDetailData;
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
