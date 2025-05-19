import 'dart:math' as math;

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
        double getHeight = 0;
        if (controller.orders.isNotEmpty) {
          getHeight = controller.orders
              .map((e) => e.getHeightForLocationCount)
              .reduce(math.max);
        }
        if (controller.orders.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: getHeight + 118,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];

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
