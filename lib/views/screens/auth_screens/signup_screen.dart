import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';

import '../../../generated/assets.dart';
import '../../../services/input_decoration.dart';
import '../../base/common_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isExpanded = false;

  List<String> languages = ["English", "Hindi", "Marathi", "Gujarati"];
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: SvgPicture.asset(Assets.svgsProfile)),
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
                      hintStyle: const TextStyle(color: Color(0xff8A8A8A))),
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
                      hintStyle: const TextStyle(color: Color(0xff8A8A8A))),
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
                      hintStyle: const TextStyle(color: Color(0xff8A8A8A))),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.black), // set text color to black
                  controller: TextEditingController(text: '+91 ${Get.find<AuthController>().numberController.text}'),
                  enabled: false,
                  decoration: CustomDecoration.inputDecoration(
                      floating: true,
                      label: 'Mobile Number',
                      icon: const Icon(
                        Icons.phone,
                        size: 25,
                        color: Color(0xff000000),
                      ),
                      hint: '+91 25652 232262 ',
                      hintStyle: const TextStyle(color: Colors.black87)),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  value: selectedLanguage,
                  dropdownColor: Colors.white,
                  decoration: CustomDecoration.dropdown(
                    floating: true,
                    context,
                    label: "Language",
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: languages.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onTap: () {
                      // Navigator.pushReplacement(context, getCustomRoute(child: Dashboard()));
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
