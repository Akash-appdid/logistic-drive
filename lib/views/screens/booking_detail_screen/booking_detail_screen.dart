import 'package:flutter/material.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/booking_app_bar.dart';
import 'components/booking_button_widget.dart';
import 'components/order_heading_widget.dart';
import 'components/order_status_widget.dart';
import 'components/pakers_and_movers_timeline_widget.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bookingAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            OrderStatusWidget(),
            OrderHeadingWidget(),
            PakersAndMoversTimeLineWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const BookingButtonWidget(),
    );
  }
}
