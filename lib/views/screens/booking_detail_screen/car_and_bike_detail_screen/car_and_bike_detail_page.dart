import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/car_and_bike_detail_screen/components/delivery_date_and_distance_widget_for_car_and_bike.dart';
import '../../../../controllers/booking_controller.dart';
import '../../../../services/extra_methods.dart';
import '../../../../services/theme.dart';
import '../components/booking_app_bar.dart';
import '../components/order_heading_widget.dart';
import '../components/order_status_widget.dart';
import 'components/booking_button_of_car_and_bike.dart';
import 'components/custom_time_line_widget_for_car_and_bike.dart';

class CarAndBikeDetailScreen extends StatefulWidget {
  const CarAndBikeDetailScreen(
      {super.key, required this.bookingId, this.isCarAndBike = false});
  final int bookingId;
  final bool isCarAndBike;

  @override
  State<CarAndBikeDetailScreen> createState() => _CarAndBikeDetailScreenState();
}

class _CarAndBikeDetailScreenState extends State<CarAndBikeDetailScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      await Get.find<BookingController>()
          .getCarAndBikeBookingDetail(id: widget.bookingId);
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   Timer.run(() async {
  //     final controller = Get.find<BookingController>();
  //     controller.setIsComplete(true);
  //     await controller.getAllBooking(isClear: true);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bookingAppBar(context, isFrmCarAndBike: true),
      body: GetBuilder<BookingController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          backgroundColor: backgroundLight,
          onRefresh: () async {
            await Get.find<BookingController>()
                .getCarAndBikeBookingDetail(id: widget.bookingId);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const OrderStatusWidget(isFrmCarAndBike: true),
                OrderHeadingWidget(
                  type: controller.carAndBokingDetailData?.bookingType ?? 'NA',
                  vehicleNumber: controller
                          .carAndBokingDetailData?.driver?.vehicleNumber ??
                      'NA',
                  vehicalName: controller
                          .carAndBokingDetailData?.vehicleData?.first.type ??
                      'NA',
                ),
                const CustomTimelineWidgetForCarAndBike(),
                const DeliveryDateAndDistanceWidgetForCarAndBike(),
                const PaymentInformationWidgetForCarAndBike(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: const BookingButtonOfCarAndBike(),
    );
  }
}

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
                  const Paymenthistory(),
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
                        "₹ ${formatPrice(controller.carAndBokingDetailData?.calcualteRemaingAmtAfterSubAmt ?? 0)}",
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

class Paymenthistory extends StatelessWidget {
  const Paymenthistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      if (controller.carAndBokingDetailData?.payoutBookingDriver?.isEmpty ??
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
                    .carAndBokingDetailData?.payoutBookingDriver?.length ??
                0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final payout = controller
                  .carAndBokingDetailData?.payoutBookingDriver?[index];

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
