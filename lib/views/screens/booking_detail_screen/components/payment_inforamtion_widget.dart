import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/title_widget.dart';

class PaymentInformationWidget extends StatelessWidget {
  const PaymentInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  title: 'Total Receivable Amount',
                  val:
                      '₹ ${controller.bookingsDetailData?.amountForDriver ?? ''}',
                ),
              ],
            ),
            if (controller
                    .bookingsDetailData?.payoutBookingGoodDrivers?.isNotEmpty ??
                false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(height: 8),
                  Text(
                    'Payment History',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller
                        .bookingsDetailData?.payoutBookingGoodDrivers?.length,
                    itemBuilder: (context, index) {
                      final payment = controller
                          .bookingsDetailData?.payoutBookingGoodDrivers?[index];
                      return TitleWidget(
                        font: 14,
                        title: 'Payment Received',
                        val: '₹ ${payment?.amount ?? ''}',
                      );
                    },
                  )
                ],
              ),
            if (controller.bookingsDetailData?.calcualteRemaingAmtAfterSubAmt !=
                0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(height: 8),
                  TitleWidget(
                    title: 'Remaining Receivable Amount',
                    val:
                        '₹ ${controller.bookingsDetailData?.calcualteRemaingAmtAfterSubAmt}',
                  ),
                ],
              ),
            const SizedBox(height: 8),
          ],
        ),
      );
    });
  }
}
