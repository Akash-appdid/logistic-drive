import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/theme.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';
import '../../../../generated/assets.dart';
import '../../../base/common_button.dart';
import '../../../base/dialogs/logout_dialog.dart';
import 'verifypickup_sheet_of_localbiketempo.dart';

class BookingButtonWidgetOfBikeTempo extends StatelessWidget {
  const BookingButtonWidgetOfBikeTempo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBikeTempoController>(builder: (controller) {
      if (controller.isLoading) {
        return const SizedBox.shrink();
      }
      if (controller.localBikeTempoBookingData?.inprocess == null) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  color: primaryColor, //const Color(0xFF0F8000),
                  onTap: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return VerifyPickUpSheetOfLocalBike(
                          orderId: controller.localBikeTempoBookingData?.id,
                        );
                      },
                    );
                  },
                  title: 'Start Trip',
                ),
              )
            ],
          ),
        );
      }
      if (controller.isDelivered() &&
          controller.localBikeTempoBookingData?.delivered == null) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  color: primaryColor, // const Color(0xFF0F8000),
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          title:
                              'Are you sure you want to mark this as delivered?',
                          imageIcon: Assets.imagesImage,
                          isLoading: controller.isLoading,
                          onTap: () {
                            controller
                                .markAsDelivredBikeTempo(
                                    id: controller
                                            .localBikeTempoBookingData?.id ??
                                        0)
                                .then((value) {
                              if (value.isSuccess) {
                                Navigator.pop(context);
                                controller.getLocalBikeTempBookingDetailData(
                                    id: controller
                                            .localBikeTempoBookingData?.id ??
                                        0);
                              } else {
                                Fluttertoast.showToast(msg: value.message);
                              }
                            });
                          },
                        );
                      },
                    );
                    //
                  },
                  title: 'Mark as Delivered',
                ),
              )
            ],
          ),
        );
      }
      if (controller.localBikeTempoBookingData?.delivered != null) {
        return const SizedBox.shrink();
      }

      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                  color: primaryColor, //const Color(0xFF0F8000),
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          title:
                              'Are you sure you want to mark ${controller.selectedLocation?.type.capitalizeFirstOfEach} ${controller.selectedLocation?.getIndex} as done?',
                          imageIcon: Assets.imagesImage,
                          isLoading: controller.isLoading,
                          onTap: () {
                            dynamic data = {
                              "booking_id":
                                  controller.localBikeTempoBookingData?.id,
                              "booking_two_wheeler_location_id":
                                  controller.selectedLocation?.id,
                            };
                            // log('---Pickup---');
                            Navigator.pop(context);

                            controller
                                .loactionMarkAsDone(data: data)
                                .then((value) {
                              if (value.isSuccess) {
                                controller.getLocalBikeTempBookingDetailData(
                                    id: controller
                                            .localBikeTempoBookingData?.id ??
                                        0);
                              } else {
                                Fluttertoast.showToast(msg: value.message);
                              }
                            });
                          },
                        );
                      },
                    );
                  },
                  title:
                      '${controller.selectedLocation?.type.capitalizeFirstOfEach} ${controller.selectedLocation?.getIndex}is done'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
