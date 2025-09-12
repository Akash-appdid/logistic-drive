import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/controllers/local_bike_tempo_controller.dart';
import 'package:logistic_driver/views/screens/dashboard/local_bike_and_tempo/local_bike_and_tempo_widget.dart';
import 'package:logistic_driver/views/screens/dashboard/truck_and_packers/truck_and_pakers_widget.dart';

import '../../../../services/theme.dart';
import '../../../base/common_button.dart';

class BookingsListSectionWidget extends StatelessWidget {
  const BookingsListSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bookings',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  radius: 10,
                  elevation: 2,
                  color:
                      controller.isOnGoingOrder ? primaryColor : Colors.white,
                  type: controller.isOnGoingOrder
                      ? ButtonType.primary
                      : ButtonType.secondary,
                  onTap: () {
                    final authCtrl = Get.find<AuthController>();
                    final localBikeCtrl = Get.find<LocalBikeTempoController>();
                    if (controller.isLoading || localBikeCtrl.isLoading) {
                      Fluttertoast.showToast(
                          msg: 'Please wait data is loading');
                      return;
                    }
                    controller.setIsComplete(true);
                    if (controller.isOnGoingOrder) {
                      if (authCtrl.userModel?.isMotorbike ?? false) {
                        localBikeCtrl.getAllOrder(isClear: true);
                      } else {
                        controller.getAllBooking(isClear: true);
                        controller.getAllCarandBikesBooking();
                      }
                    }
                  },
                  title: 'On Going',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  elevation: 2,
                  radius: 10,
                  color:
                      !controller.isOnGoingOrder ? primaryColor : Colors.white,
                  type: !controller.isOnGoingOrder
                      ? ButtonType.primary
                      : ButtonType.secondary,
                  onTap: () {
                    final authCtrl = Get.find<AuthController>();
                    final localBikeCtrl = Get.find<LocalBikeTempoController>();
                    if (controller.isLoading || localBikeCtrl.isLoading) {
                      Fluttertoast.showToast(
                          msg:
                              'Please wait a moment while we load your content.');
                      return;
                    }

                    controller.setIsComplete(false);
                    if (!controller.isOnGoingOrder) {
                      if (authCtrl.userModel?.isMotorbike ?? false) {
                        localBikeCtrl.getAllOrder(
                            status: 'delivered', isClear: true);
                      } else {
                        controller
                            .handlecompleteOrdersTab(CompleteOrderType.goods);
                        controller.getAllBooking(
                            status: 'delivered', isClear: true);
                        // controller.getAllBooking(
                        //     status: 'delivered', isClear: true);
                      }
                    }
                  },
                  title: 'Completed',
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          GetBuilder<AuthController>(
            builder: (authCtrl) {
              log('${authCtrl.userModel?.isMotorbike}');
              if (authCtrl.userModel?.isMotorbike ?? false) {
                return const LocalBikeAndTempoWidget();
              }
              return const TruckAndPakersWidget();
            },
          ),
        ],
      );
    });
  }
}
