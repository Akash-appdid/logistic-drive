import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../controllers/booking_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../../services/theme.dart';
import '../../../../base/common_button.dart';
import '../../../../base/dialogs/logout_dialog.dart';
import '../../components/verify_pickup_sheet.dart';

class BookingButtonOfCarAndBike extends StatelessWidget {
  const BookingButtonOfCarAndBike({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      log("${controller.carAndBokingDetailData?.id}", name: 'Order');
      if (controller.isLoading) {
        return const SizedBox.shrink();
      }
      if (controller.carAndBokingDetailData?.intransit == null) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  color: primaryColor,
                  onTap: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return VerifyPickUpSheet(
                          isCarAndBike: true,
                          orderId: controller.carAndBokingDetailData?.id,
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
      if (controller.carAndBokingDetailData?.pickupDoneAt == null) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(
                    color: primaryColor,
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return ConfirmationDialog(
                            title:
                                'Are you sure you want to mark Pickup as done?',
                            imageIcon: Assets.imagesImage,
                            isLoading: controller.isLoading,
                            onTap: () {
                              log('---Pickup---');
                              Navigator.pop(context);
                              controller
                                  .markAsDonrForCarAndBike(
                                bookingId:
                                    controller.carAndBokingDetailData?.id ?? 0,
                                isPickup: true,
                              )
                                  .then((value) {
                                if (value.isSuccess) {
                                  controller.getCarAndBikeBookingDetail(
                                      id: controller
                                              .carAndBokingDetailData?.id ??
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
                    title: 'Pickup is done'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }
      if (controller.carAndBokingDetailData?.dropDoneAt == null) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(
                  color: primaryColor,
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          title: 'Are you sure you want to mark Drop as done?',
                          imageIcon: Assets.imagesImage,
                          isLoading: controller.isLoading,
                          onTap: () {
                            log('---Drop---');
                            Navigator.pop(context);
                            controller
                                .markAsDonrForCarAndBike(
                                    bookingId:
                                        controller.carAndBokingDetailData?.id ??
                                            0)
                                .then((value) {
                              if (value.isSuccess) {
                                controller.getCarAndBikeBookingDetail(
                                    id: controller.carAndBokingDetailData?.id ??
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
                  title: 'Drop is done',
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }

      if (controller.carAndBokingDetailData?.delivered == null) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  color: primaryColor, //const Color(0xFF0F8000),
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
                                .orderDeliveredForCarAndBike(
                                    bookingId:
                                        controller.carAndBokingDetailData?.id ??
                                            0)
                                .then((value) {
                              if (value.isSuccess) {
                                Navigator.pop(context);
                                controller.getCarAndBikeBookingDetail(
                                    id: controller.carAndBokingDetailData?.id ??
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

      return const SizedBox.shrink();
    });
  }
}
