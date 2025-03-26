import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

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
        // surfaceTintColor: Colors.white,
        // backgroundColor: Colors.white,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent,
        // ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const CustomImage(
                  path:
                      "https://s3-alpha-sig.figma.com/img/885b/4adb/5485ef1e61a0b521b0bd6a047e74046d?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KDrR8SVdeRKeWZDWZktd9QCWI~qKsH~4CrO2DQyhFi-wX~OE7KEgGObqWYYiy3NjPeqnML538nR2XzdG~fvaiSCwQ7uGP0FTvliC5Q-oLodsoHDejk4Nnh-Ba9o9lNMnmp4IMX-Z3N9BsIzIbf13jddUobuh2yeMAbVF5tP0Xjv-7Pccy3-GZvmdQ06WXBsuuLRAmYQnteZr1gsx-nO8sSLrWpKUFjedbMbAQjGeD4AdmaycBYhdzyvLVqiSUoiKNgHvHvf17Bjb0nH5wl2jxmyNPiwERGImW8cZqMkTKGGR4bFqFC~HcwKRRtSuG7O0-8TArOEuEPgG5i6G-XDDRA__",
                  radius: 30,
                  height: 100,
                ),
                Positioned(
                    top: -8,
                    right: -8,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00C060),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset(Assets.svgsEdit),
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Kunal Pawar",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Center(
            child: Text(
              "Kunalpawar@gmail.com",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black, fontSize: 13),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Color(0xFFD9D9D9),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Info",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
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
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Mobile No: ",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "+91 21323 23032",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                                      )
                                    ]),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFF5F5F5),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Email ID: ",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "abc12@gmail.com",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                                      )
                                    ]),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Professional info",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
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
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Pan Card: ",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "222132323032",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                                      )
                                    ]),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFF5F5F5),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Driving Licence: ",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "EXYJ345",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                                      )
                                    ]),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Vehicle Info",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
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
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Motor Bike: ",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "MH-19-AG-5465",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                                      )
                                    ]),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFF5F5F5),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Mini Truck: ",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "MH-19-AG-5465",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xFF8A8A8A), fontSize: 14),
                                      )
                                    ]),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              )
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
    );
  }
}
