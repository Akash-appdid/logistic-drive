import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/components/certificate_image.dart';

import '../../../../../../controllers/register_controller.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../services/input_decoration.dart';
import '../../../../../../services/route_helper.dart';
import '../../../../../base/dropdown_killer.dart';

class MotorbikeWidget extends StatelessWidget {
  const MotorbikeWidget({
    super.key,
    required this.controller,
  });
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
    );
  }
}
