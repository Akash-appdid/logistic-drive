import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/pusher_controller.dart';
import 'orders_item_widget.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PusherController>(
      builder: (PusherController controller) {
        if (controller.orders.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              log("${order.bookingType}");
              return OrdersItemWidget(
                width: controller.orders.length == 1
                    ? size.width * .91
                    : size.width * .86,
                orderData: order,
              );
            },
          ),
        );
      },
    );
  }
}
