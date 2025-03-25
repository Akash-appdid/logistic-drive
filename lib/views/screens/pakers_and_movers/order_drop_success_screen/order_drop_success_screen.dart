import 'package:flutter/material.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

class OrderDropSuccessScreen extends StatelessWidget {
  const OrderDropSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomImage(
                  width: 100,
                  height: 100,
                  path: Assets.imagesCheck,
                  color: Color(0xFF0F8000),
                ),
                const SizedBox(height: 10),
                Text(
                  'Successfully',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'You have successfully completed your trip.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              color: const Color(0xFF0F8000),
              onTap: () {},
              title: 'Continue',
            ),
          )
        ],
      ),
    );
  }
}
