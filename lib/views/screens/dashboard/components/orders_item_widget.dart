import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/pusher_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';
import '../../../../data/models/response/order_model.dart';
import '../../../../services/extra_methods.dart';
import '../../../../services/theme.dart';
import '../../../base/custom_progress_indicator.dart';
import 'location_contaner_widget.dart';

class OrdersItemWidget extends StatefulWidget {
  final OrderModel orderData;
  final double? height;
  final double? width;
  const OrdersItemWidget(
      {super.key, required this.orderData, this.height, this.width});

  @override
  State<OrdersItemWidget> createState() => _OrdersItemWidgetState();
}

class _OrdersItemWidgetState extends State<OrdersItemWidget> {
  bool orderAcceptLoading = false;
  bool orderRejectLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'ID #${(widget.orderData.bookingId ?? '').toUpperCase()}',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
              ),
              GetBuilder<LocalBikeTempoController>(builder: (controller) {
                return InkWell(
                  onTap: () async {
                    if (controller.isLoading) return;
                    Map<String, dynamic> data = {
                      "booking_two_wheeler_id": widget.orderData.id
                    };
                    await Get.find<LocalBikeTempoController>()
                        .acceptOrder(data: data)
                        .then((value) async {
                      if (value.isSuccess) {
                        final controller = Get.find<PusherController>();
                        controller.stopAudioPlayer();
                        controller.removeItem(
                            orderRequestId: widget.orderData.id ?? 0);
                        //
                        final orderController =
                            Get.find<LocalBikeTempoController>();
                        await orderController.getAllOrder(isClear: true);
                      }
                      Fluttertoast.showToast(msg: value.message);
                    });
                  },
                  child: Ink(
                    height: 40,
                    width: 85,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A030),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Builder(builder: (context) {
                      if (controller.isLoading) {
                        return const FittedBox(
                            child: CustomProgressIndicator(isMini: true));
                      }
                      return Center(
                        child: Text(
                          'Accept',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ),
                );
              }),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  final controller = Get.find<PusherController>();
                  controller.stopAudioPlayer();
                  controller.removeItem(
                      orderRequestId: widget.orderData.id ?? 0);
                },
                child: Ink(
                  height: 40,
                  width: 85,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF04343),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Builder(builder: (context) {
                    return Center(
                      child: Text(
                        'Reject',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: Color(0xFFD9D9D9)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.orderData.locations?.length,
            itemBuilder: (context, index) {
              final data = widget.orderData.locations?[index];
              log("${data?.name}");
              log("${data?.phone}");

              return LocationContanerWidget(
                iconColor: (data?.getLocationType ?? false)
                    ? const Color(0xff00C060)
                    : const Color(0xffEB0404),
                icon: Icons.location_on,
                label: (data?.getLocationType ?? false) ? "From" : 'To',
                name: data?.name ?? '',
                phone: "+91 ${data?.phone ?? ''}",
                address: data?.getAddress ?? '',
              );
            },
          ),
          const Spacer(),
          Divider(color: Colors.grey.shade200),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatSentence((widget.orderData.bookingType ?? '')
                          .capitalizeFirstOfEach),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: green,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formatSentence(widget.orderData.status ?? 'NA')
                        .capitalizeFirstOfEach,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
