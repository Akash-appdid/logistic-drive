import 'package:flutter/material.dart';

import '../../../../services/route_helper.dart';
import '../../../../services/theme.dart';
import '../../../base/common_button.dart';
import '../../dashboard/components/location_contaner_widget.dart';
import '../../order_drop_success_screen/order_drop_success_screen.dart';

class StartDrivingWidget extends StatelessWidget {
  const StartDrivingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
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
                  radius: 25,
                  child: Icon(
                    Icons.headphones,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Support',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      Text(
                        'Customer support',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
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
                      radius: 25,
                      child: Icon(
                        Icons.message,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: const Color(0xFFF2F2F2),
                      radius: 25,
                      child: Icon(
                        Icons.call,
                        color: primaryColor,
                        size: 20,
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
                Navigator.of(context).push(
                    getCustomRoute(child: const OrderDropSuccessScreen()));
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
    );
  }
}
