import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/base/date_picker_widget.dart';

import '../../../../../services/input_decoration.dart';

import '../../../../base/image_picker_sheet.dart';

class SignupPageTwo extends StatefulWidget {
  const SignupPageTwo({super.key});

  @override
  State<SignupPageTwo> createState() => _SignupPageTwoState();
}

class _SignupPageTwoState extends State<SignupPageTwo> {
  File? registrationCertificate;
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController vehicleBuildYear = TextEditingController();

  List<Map<String, String>> vehicleWeightType = [
    {
      "name": "Tata Ace",
      "weight": "1000 kg",
    },
    {
      "name": "Pick Up",
      "weight": "1900 kg",
    },
    {
      "name": "Tata 407",
      "weight": "2000 kg",
    },
    {
      "name": "14 Feet",
      "weight": "3000 kg",
    },
  ];
  Map<String, String>? selectedVehicleWeight;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(Assets.svgsTruck))),
                const SizedBox(height: 25),
                Text(
                  "Tell Us About Your Vehicle",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  "Fill in the details to get started with quick and easy deliveries.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(4),
                  value: selectedVehicleWeight,
                  dropdownColor: Colors.white,
                  decoration: CustomDecoration.inputDecoration(
                    borderRadius: 10,
                    floating: true,
                    label: "Select Vehicle here",
                    hint: 'Select Vehicle here',
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: vehicleWeightType.map((Map<String, String> value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value["name"].toString(),
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            value["weight"].toString(),
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {},
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: vehicleNumber,
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderRadius: 4,
                          label: 'Vehicle Number',
                          hint: 'Enter vehicle number',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: TextEditingController(text: registrationCertificate?.path.fileName ?? ""),
                        readOnly: true,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderRadius: 4,
                          label: 'Registration Certificate',
                          suffix: SizedBox(
                            width: 120,
                            child: Center(
                              child: GestureDetector(
                                  child: const Text('Select file'),
                                  onTap: () async {
                                    registrationCertificate = await getImageBottomSheet(context);
                                    // setState(() {});
                                  }),
                            ),
                          ),
                          hint: 'Registration Certificate',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomDatePicker(
                        datePickerMode: DatePickerMode.year,
                        onChanged: (DateTime? dateTime) {
                          if (dateTime != null) {
                            setState(() {
                              vehicleBuildYear.text = dateTime.year.toString();
                            });
                          }
                        },
                        today: false,
                        child: TextFormField(
                          controller: vehicleBuildYear,
                          style: const TextStyle(color: Colors.black),
                          enabled: false,
                          readOnly: true,
                          decoration: CustomDecoration.inputDecoration(
                            borderRadius: 4,
                            floating: true,
                            label: 'Build Year',
                            hint: 'Select Year',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 75),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
