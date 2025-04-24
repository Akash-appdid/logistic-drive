import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/views/base/common_button.dart';

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
      await Get.find<BookingController>().getHomeItemList();
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
      body: GetBuilder<BookingController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
      bottomNavigationBar:
          SafeArea(child: GetBuilder<BookingController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                isLoading: controller.isLoading,
                onTap: () {
                  Map<String, dynamic> data = {
                    "booking_good_id": controller.bookingsDetailData?.id,
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
                      controller.getBookingDetail(
                          id: controller.bookingsDetailData?.id ?? 0);
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
