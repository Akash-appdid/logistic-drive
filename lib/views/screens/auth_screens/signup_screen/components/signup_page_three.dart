import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/register_controller.dart';
import 'package:logistic_driver/data/models/response/vehicle_master_model.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

import 'package:logistic_driver/views/base/dialogs/custom_nodata_found.dart';

import '../../../../../services/input_decoration.dart';

import 'components/certificate_image.dart';

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
      controller.cleanSignupPageThree();
      if (controller.selectedVehicle != null) {
        await controller
            .getVehicleMasterData(
                vehicleType: controller.selectedVehicle?.key ?? '')
            .then((value) {});
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
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.vehicleMasterData.isEmpty) {
            return const CustomNoDataFoundWidget(
              text:
                  'Sorry, no vehicles are available for your selection. Please choose a different vehicle.',
            );
          }
          return RefreshIndicator(
            color: Colors.white,
            onRefresh: () async {
              controller.cleanSignupPageThree();
              controller.getVehicleMasterData(
                  vehicleType: controller.selectedVehicle?.key ?? '');
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(Assets.svgsTruck))),
                      const SizedBox(height: 25),
                      Text(
                        "Tell Us About Your Vehicle",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontWeight: FontWeight.normal, fontSize: 30),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Fill in the details to get started with quick and easy deliveries.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField(
                        validator: (val) {
                          if (val == null) {
                            return "Select vehicle";
                          }
                          return null;
                        },
                        borderRadius: BorderRadius.circular(4),
                        value: controller.vehicleMasterModel,
                        dropdownColor: Colors.white,
                        decoration: CustomDecoration.inputDecoration(
                          borderRadius: 10,
                          floating: true,
                          label: "Select Vehicle here",
                          hint: 'Select Vehicle here',
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.vehicleMasterData
                            .map((VehicleMasterModel value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (value.name ?? 'NA').capitalizeFirstOfEach,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 16, color: Colors.black),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "${value.weight}Kg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedVehicleMaster(value);
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFD9D9D9),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehicle Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller.vehicleNumber,
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomDecoration.inputDecoration(
                                floating: true,
                                borderRadius: 4,
                                label: 'Vehicle Number',
                                hint: 'Enter vehicle number',
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter vehicle number!";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const CertificateImageWidget(),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                controller.selectYear(context);
                              },
                              child: TextFormField(
                                controller: controller.buildYear,
                                style: const TextStyle(color: Colors.black),
                                enabled: false,
                                readOnly: true,
                                decoration: CustomDecoration.inputDecoration(
                                  borderRadius: 4,
                                  floating: true,
                                  label: 'Build Year',
                                  hint: 'Select Year',
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Select build year!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 75),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
