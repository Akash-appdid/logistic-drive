import 'package:flutter/material.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/pakers_and_movers/order_drop_success_screen/order_drop_success_screen.dart';

import '../../dashboard/components/location_contaner_widget.dart';

class PakersAndMoversPickupLocationScreen extends StatelessWidget {
  const PakersAndMoversPickupLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking ID #23263513614',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: const CustomImage(
        width: double.infinity,
        height: double.infinity,
        path: Assets.imagesBigMap,
        fit: BoxFit.cover,
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    child: Icon(
                      Icons.headphones,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Support',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          'Customer support',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFF2F2F2),
                        radius: 28,
                        child: Icon(
                          Icons.message,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: const Color(0xFFF2F2F2),
                        radius: 28,
                        child: Icon(
                          Icons.call,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Color(0xFFD9D9D9)),
            const LocationContanerWidget(
              iconColor: Color(0xff00C060),
              icon: Icons.location_on,
              label: "From",
              name: "Kunal Pawar",
              phone: "+91 89455 53123",
              address: "Gopi Tank Marg, Mahim West, Shivaji Park...",
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                color: const Color(0xFF0F8000),
                height: 50,
                onTap: () {
                  Navigator.of(context).push(getCustomRoute(child: const OrderDropSuccessScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
