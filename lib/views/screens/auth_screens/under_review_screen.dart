import 'package:flutter/material.dart';
import 'package:logistic_driver/services/extra_methods.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

class ProfileUnderReviewScreen extends StatelessWidget {
  const ProfileUnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(
                path: Assets.imagesProfileUnderReview,
                fit: BoxFit.contain,
                height: 300,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Profile Under Review!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "We are in the process of reviewing your profile. This may take some time. You will be notified once your profile is approved. Thank you for your patience.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                onTap: () {
                  ExtraMethods().makeCall("+919876543210");
                },
                child: Text(
                  "Support",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
