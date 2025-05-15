import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/local_bike_tempo_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../services/theme.dart';
import '../../../base/common_button.dart';

class VerifyPickUpSheetOfLocalBike extends StatefulWidget {
  final int? orderId;
  const VerifyPickUpSheetOfLocalBike({super.key, this.orderId});

  @override
  State<VerifyPickUpSheetOfLocalBike> createState() =>
      _VerifyPickUpSheetOfLocalBikeState();
}

class _VerifyPickUpSheetOfLocalBikeState
    extends State<VerifyPickUpSheetOfLocalBike> {
  TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Get.find<UpdateOrderController>()
      //     .confirmTriggerCartEvent(orderId: widget.orderId)
      //     .then((value) {
      //   if (!value.isSuccess) Fluttertoast.showToast(msg: value.message);
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Timer.run(() {
      otpController.clear();
      otpController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      width: double.infinity,
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Verify OTP",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter the OTP sent to the user’s app to start the trip.",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: PinCodeTextField(
                  controller: otpController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter OTP";
                    return null;
                  },
                  showCursor: true,
                  cursorColor: Colors.grey.withOpacity(0.5),
                  cursorHeight: 14,
                  autoDisposeControllers: false,
                  appContext: context,
                  length: 6,
                  onCompleted: (value) async {},
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 50,
                    fieldWidth: MediaQuery.of(context).size.width * 0.12,
                    activeFillColor: Colors.white,
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: primaryColor,
                  ),
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                ),
              ),
              const SizedBox(height: 5),
              GetBuilder<LocalBikeTempoController>(builder: (controller) {
                return CustomButton(
                  elevation: 0,
                  radius: 10,
                  isLoading: controller.isLoading,
                  onTap: () async {
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    await controller
                        .startBikeTempoBookingTrip(
                      tripOtp: otpController.text,
                      bookingId: controller.localBikeTempoBookingData?.id ?? 0,
                    )
                        .then((value) {
                      if (value.isSuccess) {
                        controller.getLocalBikeTempBookingDetailData(
                            id: controller.localBikeTempoBookingData?.id ?? 0);
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(msg: value.message);
                      }
                    });
                  },
                  title: "Submit",
                );
              }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                elevation: 0,
                type: ButtonType.secondary,
                radius: 10,
                onTap: () {
                  Navigator.pop(context);
                },
                title: "Cancel",
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
