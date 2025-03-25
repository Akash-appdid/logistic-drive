import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/auth_screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {});
  }

  List sliderList = [
    {
      "image": Assets.imagesDeliveryBike,
      "title": "On-Demand Logistics Made Easy",
      "subtitle": "Need to transport goods? Book a ride in seconds and get hassle-free delivery at your doorstep."
    },
    {
      "image": Assets.imagesDeliveryTruck,
      "title": "Reliable & Affordable",
      "subtitle": "Trusted delivery partners ensure your goods reach safely and on time, at the best prices."
    },
    {
      "image": Assets.imagesIllustration,
      "title": "Track & Manage Deliveries",
      "subtitle": "Track your delivery in real time, manage bookings, and get instant updates—all in one place."
    },
  ];
  int currentIndex = 0;

  CarouselSliderController carouselSliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              carouselController: carouselSliderController,
              options: CarouselOptions(
                height: 450,
                // aspectRatio: 16 / 9,
                autoPlay: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  currentIndex = index;
                  setState(() {});
                },
              ),
              items: sliderList.map((slide) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 0),
                              child: CustomImage(
                                path: slide["image"],
                                fit: BoxFit.contain,
                                height: 170,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            slide["title"] ?? "",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            slide["subtitle"] ?? "",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < sliderList.length; i++)
                  Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == i ? primaryColor : Color(0xFFD9D9D9),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onTap: () {
                if (currentIndex == sliderList.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    getCustomRoute(
                      child: const LoginScreen(),
                    ),
                  );
                } else {
                  carouselSliderController.animateToPage(currentIndex + 1);
                }
              },
              elevation: 0,
              radius: 8,
              child: Text(
                "Next",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
