import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/controllers/packer_mover_controller.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/base/dialogs/custom_nodata_found.dart';

import 'components/add_item_sub_widget.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      await Get.find<PackerAndMoverController>().getHomeItemList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item',
        ),
      ),
      body: GetBuilder<PackerAndMoverController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.groupHomeItemList.isEmpty) {
            return const CustomNoDataFoundWidget();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.groupHomeItemList.length,
                  itemBuilder: (context, index) {
                    final homeItem = controller.groupHomeItemList[index];
                    return AddItemSubWidget(
                      homeItem: homeItem,
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: GetBuilder<PackerAndMoverController>(builder: (controller) {
        if (controller.groupHomeItemList.isEmpty) {
          return const SizedBox.shrink();
        }
        if (!controller.isAddItem()) {
          return const SizedBox.shrink();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomButton(
                isLoading: controller.isLoading,
                onTap: () {
                  final bookingController = Get.find<BookingController>();
                  Map<String, dynamic> data = {
                    "booking_good_id": bookingController.bookingsDetailData?.id,
                    "home_items": [],
                  };

                  for (var homelist in controller.groupHomeItemList) {
                    for (var item in homelist) {
                      log("${item.itemQuantity}");
                      if (item.itemQuantity != 0) {
                        data["home_items"].add({
                          "id": item.id,
                          "quantity": item.itemQuantity,
                        });
                      }
                    }
                  }
                  log("$data");
                  controller.addHomeItem(data: data).then((value) {
                    if (value.isSuccess) {
                      Fluttertoast.showToast(msg: value.message);
                      bookingController.getBookingDetail(
                          id: bookingController.bookingsDetailData?.id ?? 0);
                      Navigator.of(context).pop();
                    }
                  });
                },
                title: 'Add item',
              ),
            ),
          ],
        );
      })),
    );
  }
}
