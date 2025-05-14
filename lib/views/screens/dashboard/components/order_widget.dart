import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/pusher_controller.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PusherController>(
      builder: (PusherController controller) {
        // if (controller.orders.isEmpty) {
        //   return const SizedBox.shrink();
        // }
        return SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              return Text('text');
              //  OrdersItemWidget(
              //   width: controller.orders.length == 1
              //       ? size.width * .91
              //       : size.width * .86,
              //   orderRequestId: controller.orders[index].orderRequest?.id ?? 0,
              //   orderRequest: controller.orders[index].orderRequest ??
              //       OrderRequestModel(),
              // );
            },
          ),
        );
      },
    );
  }
}
