import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/controllers/packer_mover_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/dialogs/custom_nodata_found.dart';

import '../../../../data/models/response/booking_model.dart';
import '../../../../services/theme.dart';
import '../../../base/common_button.dart';
import 'components/home_edit_sub_item_widget.dart';

class HomeEditItemScreen extends StatelessWidget {
  const HomeEditItemScreen({
    super.key,
    this.homeItem,
    required this.bookingId,
  });
  final List<BookingGoodHomeItem>? homeItem;
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          homeItem?.first.getHomeDatCategoryTitle.capitalizeFirstOfEach ?? 'NA',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
        ),
      ),
      body: GetBuilder<PackerAndMoverController>(builder: (controller) {
        if (homeItem?.isEmpty ?? true) {
          return const CustomNoDataFoundWidget();
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: homeItem?.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = homeItem?[index];
                  return HomeEditSubItemWidget(
                    item: item,
                    bookingHomeItem: homeItem,
                  );
                },
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: SafeArea(
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
                          final bookingControler =
                              Get.find<BookingController>();
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
      ),
    );
  }
}
