import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:logistic_driver/controllers/packer_mover_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../../data/models/response/booking_model.dart';

class HomeEditSubItemWidget extends StatelessWidget {
  const HomeEditSubItemWidget({
    super.key,
    this.item,
    this.bookingHomeItem,
  });
  final BookingGoodHomeItem? item;
  final List<BookingGoodHomeItem>? bookingHomeItem;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackerAndMoverController>(initState: (_) {
      Timer.run(() {
        Get.find<PackerAndMoverController>()
            .updateItemQuantity(homeItem: item, initialize: true);
      });
    }, builder: (controller) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(children: [
            Expanded(
              child: Text(
                (item?.homeItemData?.title ?? 'NA').capitalizeFirstOfEach,
              ),
            ),
            //
            SizedBox(
              width: 105,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateItemQuantity(
                        homeItem: item,
                        decrement: true,
                        selectedHomeItemList: bookingHomeItem,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color(0xff09596F),
                      ),
                      width: 30,
                      height: 30,
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "${item?.itemQuantity}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      controller.updateItemQuantity(
                          homeItem: item, increment: true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color(0xff09596F),
                      ),
                      width: 30,
                      height: 30,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ]));
    });
  }
}
