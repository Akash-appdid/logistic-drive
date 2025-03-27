import 'package:flutter/material.dart';

import 'package:logistic_driver/views/screens/booking_detail_screen/components/booking_app_bar.dart';

import 'components/booking_button_widget.dart';
import 'components/custom_timeline_widget.dart';
import 'components/delivery_date_and_distance_widget.dart';
import 'components/order_heading_widget.dart';
import 'components/order_status_widget.dart';
import 'components/order_tracking_status_widget.dart';
import 'components/payment_inforamtion_widget.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bookingAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OrderStatusWidget(),
            const OrderHeadingWidget(),
            const CustomTImelineWidget(),
            Divider(color: Colors.grey.shade200, thickness: 10),
            const OrderTrackingStatusWidget(),
            const DeliveryDateAndDistanceWidget(),
            const PaymentInformationWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const BookingButtonWidget(),
    );
  }
}
