import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../../../controllers/register_controller.dart';
import '../../../../../../data/models/response/vehicle_master_model.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../services/input_decoration.dart';
import '../../../../../../services/route_helper.dart';
import '../../../../../base/dialogs/custom_nodata_found.dart';
import '../../../../../base/dropdown_killer.dart';
import 'certificate_image.dart';

class OpentruckAndBodyPackTruckWidget extends StatelessWidget {
  const OpentruckAndBodyPackTruckWidget({
    super.key,
    required this.isFrmProfile,
  });
  final bool isFrmProfile;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
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
          if (isFrmProfile) return;
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
                        .copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Fill in the details to get started with quick and easy deliveries.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
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
                                  .copyWith(fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${value.weight}Kg",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (isFrmProfile) return;
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
                          readOnly: isFrmProfile,
                          keyboardType: TextInputType.text,
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
                            if (isFrmProfile) return;
                            Navigator.push(
                              context,
                              getCustomRoute(
                                child: DropDownKiller(
                                  data: controller.buildYearList,
                                  title: "Select",
                                  onSelected: (result) {
                                    controller.selectYear(result);
                                  },
                                ),
                              ),
                            );
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
    });
  }
}
