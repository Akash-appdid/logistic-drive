import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/register_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/signup_page_five.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/signup_page_four.dart';
import '../../../../services/route_helper.dart';
import '../../../base/common_button.dart';
import '../../dashboard/dashboard_screen.dart';
import 'components/signup_page_one.dart';
import 'components/signup_page_two.dart';
import 'components/signup_page_three.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final PageController controller = PageController();
  List<Widget> signupPages = [
    const SignupPageOne(),
    const SignUpPageTwo(),
    const SignupPageThree(),
    const SignupPageFour(),
    const SignUpPageFive(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      final controller = Get.find<AuthController>();
      if (controller.userModel != null) {
        controller.setNumber();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < signupPages.length; i++)
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: selectedIndex < i
                                      ? Colors.grey
                                      : primaryColor,
                                  height: 2,
                                ),
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: selectedIndex < i
                                    ? Colors.grey
                                    : primaryColor,
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: selectedIndex < i
                                      ? Colors.grey
                                      : primaryColor,
                                  height: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: PageView.builder(
                    // controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (val) {
                      setState(() {
                        selectedIndex = val;
                      });
                    },
                    itemCount: signupPages.length,
                    itemBuilder: (context, index) {
                      return signupPages[selectedIndex];
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (selectedIndex != 0)
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            if (selectedIndex > 0) {
                              selectedIndex--;
                              setState(() {});
                            }
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                          GetBuilder<RegisterController>(builder: (controller) {
                        return CustomButton(
                          isLoading: controller.isLoading,
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              if (selectedIndex < signupPages.length - 1) {
                                if (selectedIndex == 1) {
                                  if (controller.selectedVehicle == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Select vehicle');
                                  } else {
                                    selectedIndex++;
                                    setState(() {});
                                  }
                                } else {
                                  selectedIndex++;
                                  setState(() {});
                                }
                              } else {
                                dynamic data = {
                                  'name': controller.name.text,
                                  'email': controller.email.text,
                                  'vehicle_type':
                                      controller.selectedVehicle?.key,
                                  'vehicle_id':
                                      controller.vehicleMasterModel?.id,
                                  'vehicle_number':
                                      controller.vehicleNumber.text,
                                  'build_year': controller.buildYear.text,
                                  'registration_certificate': controller
                                              .selectedRegistrationFile !=
                                          null
                                      ? MultipartFile(
                                          controller.selectedRegistrationFile,
                                          filename: controller
                                              .selectedRegistrationFile!
                                              .path
                                              .fileName)
                                      : null,
                                  'driving_licence':
                                      controller.selectedDrivingLicense != null
                                          ? MultipartFile(
                                              controller.selectedDrivingLicense,
                                              filename: controller
                                                  .selectedDrivingLicense!
                                                  .path
                                                  .fileName)
                                          : null,
                                  'aadhar_card_front':
                                      controller.selectedAadhaarCard != null
                                          ? MultipartFile(
                                              controller.selectedAadhaarCard,
                                              filename: controller
                                                  .selectedAadhaarCard!
                                                  .path
                                                  .fileName)
                                          : null,
                                  'cancel_check':
                                      controller.selecedCancelCheck != null
                                          ? MultipartFile(
                                              controller.selecedCancelCheck,
                                              filename: controller
                                                  .selecedCancelCheck!
                                                  .path
                                                  .fileName)
                                          : null,
                                  'aadhar_card_back': controller
                                              .selectedRegistrationFile !=
                                          null
                                      ? MultipartFile(
                                          controller.selectedRegistrationFile,
                                          filename: controller
                                              .selectedRegistrationFile!
                                              .path
                                              .fileName)
                                      : null,
                                  'pan_card': controller.selectedPancard != null
                                      ? MultipartFile(
                                          controller.selectedPancard,
                                          filename: controller
                                              .selectedPancard!.path.fileName)
                                      : null,
                                  'payee_name': controller.payeeName.text,
                                  'account_number':
                                      controller.accountNumber.text,
                                  'ifsc_code': controller.ifscCode.text,
                                  'bank_name': controller.bankName.text,
                                  'bank_branch': controller.branchName.text,
                                };
                                log("$data");
                                controller
                                    .registerUser(data: data)
                                    .then((value) {
                                  if (value.isSuccess) {
                                    Fluttertoast.showToast(msg: value.message);

                                    Navigator.of(context).pushAndRemoveUntil(
                                      getCustomRoute(
                                          child: const DashboardScreen()),
                                      (route) => false,
                                    );
                                    Get.find<AuthController>()
                                        .getUserProfileData();
                                  }
                                });
                              }
                            }
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
