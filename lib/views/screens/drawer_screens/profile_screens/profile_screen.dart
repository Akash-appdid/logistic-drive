import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/extra_methods.dart';

import '../../../../data/models/response/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return RefreshIndicator(
          color: Colors.white,
          onRefresh: () async {
            controller.getUserProfileData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      getInitialLetter(controller.userModel?.name),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    (controller.userModel?.name ?? 'NA').capitalizeFirstOfEach,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 6),
                if (controller.userModel?.email != null)
                  Center(
                    child: Text(
                      controller.userModel?.email ?? 'NA',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.black, fontSize: 13),
                    ),
                  ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color(0xFFD9D9D9),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingWidget(
                        title: "Contact Info",
                      ),
                      const SizedBox(height: 8),
                      TitleAndValueWidget(
                        userModel: controller.userModel,
                      ),

                      const SizedBox(height: 20),
                      // Text(
                      //   "Professional info",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .labelLarge!
                      //       .copyWith(color: Colors.black),
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(12),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.05),
                      //           blurRadius: 8,
                      //           spreadRadius: 0,
                      //           offset: const Offset(0, 4),
                      //         ),
                      //       ],
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 16, right: 16, top: 20, bottom: 4),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(
                      //                     text: "Pan Card: ",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .labelLarge!
                      //                         .copyWith(color: Colors.black),
                      //                     children: [
                      //                       TextSpan(
                      //                         text: "222132323032",
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .labelLarge!
                      //                             .copyWith(
                      //                                 color: const Color(
                      //                                     0xFF8A8A8A),
                      //                                 fontSize: 14),
                      //                       )
                      //                     ]),
                      //               ),
                      //               const Icon(
                      //                 Icons.arrow_forward_ios,
                      //                 size: 18,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         const Divider(
                      //           color: Color(0xFFF5F5F5),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 16, right: 16, bottom: 20, top: 4),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(
                      //                     text: "Driving Licence: ",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .labelLarge!
                      //                         .copyWith(color: Colors.black),
                      //                     children: [
                      //                       TextSpan(
                      //                         text: "EXYJ345",
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .labelLarge!
                      //                             .copyWith(
                      //                                 color: const Color(
                      //                                     0xFF8A8A8A),
                      //                                 fontSize: 14),
                      //                       )
                      //                     ]),
                      //               ),
                      //               const Icon(
                      //                 Icons.arrow_forward_ios,
                      //                 size: 18,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Text(
                        "Vehicle Info",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 20, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: "Vehicle No: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: controller.userModel
                                                      ?.vehicleNumber ??
                                                  'NA',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFF8A8A8A),
                                                      fontSize: 14),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Color(0xFFF5F5F5),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 20, top: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: "Vehicle: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: formatSentence(controller
                                                      .userModel?.vehicleType ??
                                                  'NA'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFF8A8A8A),
                                                      fontSize: 14),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TitleAndValueWidget extends StatelessWidget {
  const TitleAndValueWidget({
    super.key,
    this.userModel,
  });
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          TitleAndValue(
            title: 'Mobile No: ',
            val: "+91 ${userModel?.phone}",
          ),
          const Divider(color: Color(0xFFF5F5F5)),
          if (userModel?.email != null)
            if (userModel?.email != null)
              Column(
                children: [
                  TitleAndValue(
                    title: "Email ID: ",
                    val: userModel?.email ?? 'NA',
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

class TitleAndValue extends StatelessWidget {
  const TitleAndValue({
    super.key,
    required this.title,
    required this.val,
  });

  final String title;
  final String val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
                text: title,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
                children: [
                  TextSpan(
                    text: val,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
    );
  }
}
