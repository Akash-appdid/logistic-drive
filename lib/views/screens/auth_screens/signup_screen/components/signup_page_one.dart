import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/generated/assets.dart';
import 'package:logistic_driver/services/extensions.dart';
import '../../../../../controllers/auth_controller.dart';
import '../../../../../services/input_decoration.dart';

class SignupPageOne extends StatelessWidget {
  const SignupPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(Assets.svgsProfile),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "Let's Get to Know\n You Better",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.normal, fontSize: 30),
          ),
          const SizedBox(height: 15),
          Text(
            "Share your preferences, and we’ll ensure quick and easy deliveries.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: 'Name',
              icon: const Icon(
                Icons.person_outline,
                size: 25,
                color: Color(0xff000000),
              ),
              hint: 'Enter Your Name',
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "Name can't be empty!";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: 'Email(Optional)',
              icon: const Icon(
                Icons.email_outlined,
                size: 25,
                color: Color(0xff000000),
              ),
              hint: 'Enter Your Email',
            ),
            validator: (val) {
              if (val!.isNotEmpty && val.isNotEmail) {
                return "Enter valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: 'Address',
              icon: const Icon(
                Icons.location_on_outlined,
                size: 25,
                color: Color(0xff000000),
              ),
              hint: 'Enter Your Address',
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "Address can't be empty!";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            readOnly: true,
            enabled: false,
            controller: TextEditingController(text: '+91 ${Get.find<AuthController>().numberController.text}'),
            decoration: CustomDecoration.inputDecoration(
              label: 'Mobile Number',
              icon: const Icon(
                Icons.phone,
                size: 25,
                color: Color(0xff000000),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
