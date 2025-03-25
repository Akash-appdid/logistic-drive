import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../services/theme.dart';
import '../common_button.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  DeleteAccountDialogState createState() => DeleteAccountDialogState();
}

class DeleteAccountDialogState extends State<DeleteAccountDialog> {
  @override
  void initState() {
    super.initState();
    log("dialogue run");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: Constants.padding, top: Constants.avatarRadius + 10, right: Constants.padding, bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 5), blurRadius: 5),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'Are you sure you want to delete your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Proceed with caution: Deleting your account is a big step. Are you sure you want to go through with it? Remember, you can recover it if you log in within 48 hours.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF747474),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButton(
                      radius: 6,
                      elevation: 0,
                      color: const Color(0xFFEBEBEB),
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF46454A),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomButton(
                      radius: 6,
                      elevation: 0,
                      onTap: () async {},
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();

  static const double padding = 20;
  static const double avatarRadius = 45;
}
