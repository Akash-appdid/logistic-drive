import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/register_controller.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/signup_page_five.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/signup_page_four.dart';
import 'package:logistic_driver/views/screens/auth_screens/under_review_screen.dart';

import '../../../../services/route_helper.dart';
import '../../../base/common_button.dart';
import '../../dashboard/dashboard_screen.dart';
import 'components/signup_page_one.dart';
import 'components/signup_page_three.dart';
import 'components/signup_page_two.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, this.isFrmProfile = false});
  final bool isFrmProfile;

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
      signupPages = [
        const SignupPageOne(),
        SignUpPageTwo(
          isFrmProfile: widget.isFrmProfile,
        ),
        SignupPageThree(
          isFrmProfile: widget.isFrmProfile,
        ),
        const SignupPageFour(),
        const SignUpPageFive(),
      ];
      final authCtrl = Get.find<AuthController>();
      if (widget.isFrmProfile) {
        authCtrl.updateProfileData();
        //---updated---
      } else {
        if (authCtrl.userModel != null) {
          authCtrl.setNumber();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFrmProfile
          ? AppBar(
              title: Text(
                'Update Profile',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            )
          : null,
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
                                  color: selectedIndex < i ? Colors.grey : primaryColor,
                                  height: 2,
                                ),
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: selectedIndex < i ? Colors.grey : primaryColor,
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: selectedIndex < i ? Colors.grey : primaryColor,
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
                      child: GetBuilder<RegisterController>(builder: (controller) {
                        return CustomButton(
                          isLoading: controller.isLoading,
                          onTap: () {
                            log(selectedIndex.toString());
                            if (formkey.currentState!.validate()) {
                              if (selectedIndex < signupPages.length - 1) {
                                if (selectedIndex == 1) {
                                  if (controller.selectedVehicle == null) {
                                    Fluttertoast.showToast(msg: 'Select vehicle');
                                  } else {
                                    selectedIndex++;
                                    setState(() {});
                                  }
                                } else {
                                  selectedIndex++;
                                  setState(() {});
                                }
                              } else {
                                if (widget.isFrmProfile) {
                                  updateProfile(controller);
                                } else {
                                  signupUser(controller);
                                }
                              }
                            }
                          },
                          child: Text(
                            selectedIndex >= 3 ? "Skip & Continue" : " Continue",
                            style: const TextStyle(color: Colors.white, fontSize: 14),
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

  void signupUser(RegisterController controller) {
    controller.registerUser().then((value) {
      if (value.isSuccess) {
        final auth = Get.find<AuthController>();
        Fluttertoast.showToast(msg: value.message);
        auth.getUserProfileData().then((value) {
          if (value.isSuccess) {
            if (auth.userModel?.status == 'active') {
              Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const DashboardScreen()),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const ProfileUnderReviewScreen()),
                (route) => false,
              );
            }
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              getCustomRoute(child: const ProfileUnderReviewScreen()),
              (route) => false,
            );
          }
        });
      }
    });
  }

  void updateProfile(RegisterController controller) {
    log("${controller.updateProfileData()}");
    controller.updateProfile().then((val) {
      if (val.isSuccess) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Profile updated successfully');
        Get.find<AuthController>().getUserProfileData();
      }
    });
  }
}
