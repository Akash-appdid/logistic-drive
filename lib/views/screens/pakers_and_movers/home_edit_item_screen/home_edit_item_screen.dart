import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/packer_mover_controller.dart';
import 'package:logistic_driver/views/base/dialogs/custom_nodata_found.dart';

import '../../../../data/models/response/booking_model.dart';
import 'components/edit_home_appbar_widget.dart';
import 'components/home_edit_sub_item_widget.dart';
import 'components/update_changes_sdit_item_button.dart';

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
    return GetBuilder<PackerAndMoverController>(builder: (controller) {
      if (homeItem?.isEmpty ?? true) {
        return const CustomNoDataFoundWidget();
      }
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditHomeAppbarWidget(homeItem: homeItem),
                  const SizedBox(height: 4),
                  Divider(color: Colors.grey.shade200),
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
            ),
          ),
          const SizedBox(height: 10),
          UpdateChangesEditItemButton(homeItem: homeItem, bookingId: bookingId),
        ],
      );
    });
  }
}
