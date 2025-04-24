import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../../data/models/response/home_item_model.dart';

class AddSubitemWidget extends StatelessWidget {
  const AddSubitemWidget({super.key, this.item});
  final HomeItem? item;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(children: [
          Expanded(
            child: Text(
              (item?.title ?? 'NA').capitalizeFirstOfEach,
            ),
          ),
          GetBuilder<BookingController>(builder: (controller) {
            if (item?.itemQuantity == 0) {
              return GestureDetector(
                onTap: () {
                  controller.addAndUpdateItemQuantity(
                      homeItem: item, isAdd: true);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: const Color(0xff09596F),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Add',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                      )
                    ],
                  ),
                ),
              );
            }
            return SizedBox(
              width: 105,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.addAndUpdateItemQuantity(
                          homeItem: item, decrement: true);
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
                      controller.addAndUpdateItemQuantity(
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
            );
          })
        ]));
  }
}
