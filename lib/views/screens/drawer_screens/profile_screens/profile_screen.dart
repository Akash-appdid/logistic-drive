import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/extra_methods.dart';
import 'package:logistic_driver/views/screens/drawer_screens/profile_screens/profile_list_tile.dart';
import 'package:logistic_driver/views/screens/drawer_screens/profile_screens/profile_tab_list.dart';

import '../../../../services/route_helper.dart';
import '../../auth_screens/signup_screen/components/signup_page_five.dart';
import '../../auth_screens/signup_screen/components/signup_page_one.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      await Get.find<AuthController>().getUserProfileData();
    });
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
        final data = controller.userModel!;
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
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    (controller.userModel?.name ?? 'NA').capitalizeFirstOfEach,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 6),
                if (controller.userModel?.email != null)
                  Center(
                    child: Text(
                      controller.userModel?.email ?? 'NA',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontSize: 13),
                    ),
                  ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color(0xFFD9D9D9),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contact Info",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(getCustomRoute(
                                  child: const SignupPageOne(
                                isContactedEdit: true,
                              )));
                            },
                            child: Text(
                              "Edit",
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileListTile(title: "Mobile No", value: "${data.phone}"),
                            const Divider(color: Color(0xFFF5F5F5)),
                            ProfileListTile(title: "Email ID", value: "${data.email}"),
                            const Divider(color: Color(0xFFF5F5F5)),
                            const ProfileListTile(title: 'Address', value: 'address')
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       RichText(
                            //         text: TextSpan(text: "Mobile No : ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                            //           TextSpan(
                            //             text: "${data.phone}",
                            //             style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                            //           )
                            //         ]),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            // const Divider(
                            //   color: Color(0xFFF5F5F5),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       RichText(
                            //         text: TextSpan(text: "Email ID : ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                            //           TextSpan(
                            //             text: "${data.email}",
                            //             style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black38, fontSize: 14),
                            //           )
                            //         ]),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vehicle Info",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.of(context).push(getCustomRoute(
                          //         child: const SignupPageThree(
                          //             // isContactedEdit: true,
                          //             )));
                          //   },
                          //   child: Text(
                          //     "Edit",
                          //     style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black54),
                          //   ),
                          // ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      ProfileTabList(children: [
                        ProfileListTile(title: 'Vehicle Type', value: '${data.vehicleType?.replaceAll("_", " ")}'),
                        const Divider(color: Color(0xFFF5F5F5)),
                        ProfileListTile(title: "Vehicle number", value: "${data.vehicleNumber}"),
                        const Divider(color: Color(0xFFF5F5F5)),
                        ProfileListTile(title: 'Build year', value: '${data.buildYear}')
                      ]),

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
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
                      //           child: RichText(
                      //             text: TextSpan(text: "Vehicle number : ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //               TextSpan(
                      //                 text: "${data.vehicleNumber}",
                      //                 style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //               )
                      //             ]),
                      //           ),
                      //         ),
                      //         const Divider(
                      //           color: Color(0xFFF5F5F5),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                      //           child: RichText(
                      //             text: TextSpan(text: "Vehicle Id : ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //               TextSpan(
                      //                 text: "${data.vehicleId}",
                      //                 style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //               )
                      //             ]),
                      //           ),
                      //         ),
                      //         const Divider(
                      //           color: Color(0xFFF5F5F5),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                      //           child: RichText(
                      //             text: TextSpan(text: "Vehicle Type : ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //               TextSpan(
                      //                 text: "${data.vehicleType}",
                      //                 style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //               )
                      //             ]),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bank Info",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(getCustomRoute(
                                  child: const SignUpPageFive(
                                      //isContactedEdit: true,
                                      )));
                            },
                            child: Text(
                              "Edit",
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ProfileTabList(children: [
                        ProfileListTile(title: "Bank name", value: "${data.bankName}"),
                        const Divider(color: Color(0xFFF5F5F5)),
                        ProfileListTile(title: "Bank branch", value: "${data.bankBranch}"),
                        const Divider(color: Color(0xFFF5F5F5)),
                        ProfileListTile(title: 'Account Number', value: '${data.accountNumber}'),
                        const Divider(color: Color(0xFFF5F5F5)),
                        ProfileListTile(title: 'Payee Name', value: '${data.payeeName}')
                      ]),
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
                      //           padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(text: "Motor Bike: ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //                   TextSpan(
                      //                     text: "${data?.vehicleNumber}",
                      //                     style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //                   )
                      //                 ]),
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
                      //           padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(text: "Mini Truck: ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //                   TextSpan(
                      //                     text: "${data?.vehicleId}",
                      //                     style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //                   )
                      //                 ]),
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
                      //           padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(text: "Truck Type: ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //                   TextSpan(
                      //                     text: "${data?.vehicleType}",
                      //                     style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //                   )
                      //                 ]),
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

                      // const SizedBox(height: 20),
                      // Text(
                      //   "Professional info",
                      //   style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // ProfileTabList(children: [
                      //   ProfileListTile(title: "Mobile No", value: "${data.phone}"),
                      //   const Divider(color: Color(0xFFF5F5F5)),
                      //   ProfileListTile(title: "Email ID", value: "${data.email}"),
                      //   const Divider(color: Color(0xFFF5F5F5)),
                      //   const ProfileListTile(title: 'Address', value: 'address')
                      // ]),
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
                      //           padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(text: "Pan Card: ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //                   TextSpan(
                      //                     text: "${data.panCard}",
                      //                     style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //                   )
                      //                 ]),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         const Divider(
                      //           color: Color(0xFFF5F5F5),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(text: "Driving Licence: ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
                      //                   TextSpan(
                      //                     text: "${data.drivingLicence}",
                      //                     style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                      //                   )
                      //                 ]),
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
