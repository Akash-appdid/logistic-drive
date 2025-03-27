import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/signup_page_five.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/signup_page_four.dart';
import 'package:logistic_driver/views/screens/dashboard/dashboard_screen.dart';

import '../../../base/common_button.dart';
import 'components/signup_page_one.dart';
import 'components/signup_page_three.dart';
import 'components/signup_page_two.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController controller = PageController();
  List<Widget> signupPages = [
    const SignupPageOne(),
    const SignupPageTwo(),
    const SignUpPageThree(),
    const SignupPageFour(),
    const SignUpPageFive(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      // controller.addListener(
      //   () {
      //     selectedIndex = controller.initialPage;
      //   },
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                    child: CustomButton(
                      onTap: () {
                        if (selectedIndex < signupPages.length - 1) {
                          selectedIndex++;
                          setState(() {});
                        } else {
                          Navigator.of(context).pushAndRemoveUntil(
                            getCustomRoute(child: const DashboardScreen()),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
