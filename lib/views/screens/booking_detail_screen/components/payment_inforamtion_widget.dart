import 'package:flutter/material.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/sub_title_widget.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/title_widget.dart';

class PaymentInformationWidget extends StatelessWidget {
  const PaymentInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primaryColor.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: backgroundDark.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Your Earnings',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: 'Total Fare',
                val: '₹ 45000.00',
              ),
              // SubTitleWidget(
              //   subTitle: 'Trip Rate',
              //   val: '₹ 45000',
              // ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: 'Payment Received',
                val: '₹ 15000.00',
              ),
              SubTitleWidget(
                subTitle: 'Bank transfer',
                val: '₹ 15000',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: 'Remaining Balance Received',
                val: '₹ 30000.00',
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
