import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../controllers/booking_controller.dart';
import '../../../../../controllers/packer_mover_controller.dart';
import '../../../../../data/models/response/booking_model.dart';
import '../../../../../services/theme.dart';
import '../../../../base/common_button.dart';

class UpdateChangesEditItemButton extends StatelessWidget {
  const UpdateChangesEditItemButton({
    super.key,
    required this.homeItem,
    required this.bookingId,
  });

  final List<BookingGoodHomeItem>? homeItem;
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<PackerAndMoverController>(builder: (controller) {
            if (homeItem?.isEmpty ?? true) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isLoading: controller.isLoading,
                      color: primaryColor,
                      onTap: () {
                        final bookingControler = Get.find<BookingController>();
                        Map<String, dynamic> data = {
                          "booking_good_id": homeItem?.first.bookingGoodId,
                          "home_items": []
                        };

                        for (BookingGoodHomeItem item in homeItem ?? []) {
                          data['home_items'].add({
                            "booking_good_home_items_id": item.id,
                            "quantity": item.itemQuantity,
                          });
                        }

                        log("$data");
                        controller.updateHomeItems(data: data).then((value) {
                          if (value.isSuccess) {
                            Fluttertoast.showToast(
                                msg: 'Home items updated successfully.');
                            bookingControler.getBookingDetail(id: bookingId);
                            Navigator.of(context).pop();
                          }
                        });
                      },
                      title: 'Update  changes',
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
