import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../../controllers/booking_controller.dart';
import '../../../../../services/extra_methods.dart';

class PaymentInformationWidgetForCarAndBike extends StatelessWidget {
  const PaymentInformationWidgetForCarAndBike({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Info",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey[200]),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      Text(
                        "₹ ${formatPrice(controller.carAndBokingDetailData?.amountForDriver?.toDouble() ?? 0)}",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const PaymenthistoryForCarAndBike(),
                  Divider(color: Colors.grey[200]),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remaining Receivable Amount",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                      ),
                      Text(
                        "₹ ${formatPrice(controller.bookingsDetailData?.calcualteRemaingAmtAfterSubAmt ?? 0)}",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class PaymenthistoryForCarAndBike extends StatelessWidget {
  const PaymenthistoryForCarAndBike({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      if (controller.bookingsDetailData?.payoutBookingGoodDrivers?.isEmpty ??
          true) {
        return const SizedBox.shrink();
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.grey[200],
            thickness: 1,
          ),
          const SizedBox(height: 10),
          Text(
            "Payment History",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 15),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            shrinkWrap: true,
            itemCount: controller
                    .bookingsDetailData?.payoutBookingGoodDrivers?.length ??
                0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final payout = controller
                  .bookingsDetailData?.payoutBookingGoodDrivers?[index];

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (payout?.createdAt?.toLocal() as DateTime).dateTime,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 14,
                          color: const Color(0xff868686),
                        ),
                  ),
                  Text(
                    "₹ ${formatPrice(payout?.amount?.toDouble() ?? 0)}",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 14,
                          color: const Color(0xff868686),
                        ),
                  )
                ],
              );
            },
          ),
        ],
      );
    });
  }
}
