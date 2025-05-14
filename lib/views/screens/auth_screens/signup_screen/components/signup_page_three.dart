import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/register_controller.dart';
import 'components/mini_tempo_widget.dart';
import 'components/motor_bike_widget.dart';
import 'components/opentruck_and_bodypack_truck_widget.dart';

class SignupPageThree extends StatefulWidget {
  const SignupPageThree({super.key});

  @override
  State<SignupPageThree> createState() => _SignupPageThreeState();
}

class _SignupPageThreeState extends State<SignupPageThree> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      final controller = Get.find<RegisterController>();
      controller.genrateBuildYear();
      controller.cleanSignupPageThree();
      if (controller.selectedVehicle != null &&
          controller.selectedVehicle?.key != 'motorbike' &&
          controller.selectedVehicle?.key != 'mini_tempo') {
        await controller
            .getVehicleMasterData(
                vehicleType: controller.selectedVehicle?.key ?? '')
            .then((value) {});
      } else if (controller.selectedVehicle?.key == 'mini_tempo') {
        log("test");
        await controller.fetchMiniTruckData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<RegisterController>(builder: (controller) {
          if (controller.selectedVehicle?.key == 'motorbike') {
            return MotorbikeWidget(
              controller: controller,
            );
          }
          if (controller.selectedVehicle?.key == 'mini_tempo') {
            return const MiniTempoWidget();
          }
          return const OpentruckAndBodyPackTruckWidget();
        }),
      ),
    );
  }
}
