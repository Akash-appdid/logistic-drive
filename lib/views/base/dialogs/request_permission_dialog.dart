import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/extensions.dart';
import '../common_button.dart';
import '../custom_image.dart';

class RequestPermissionDialog extends StatelessWidget {
  const RequestPermissionDialog({Key? key, required this.permission, this.extraMessage}) : super(key: key);

  final String permission;
  final String? extraMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              path: Assets.imagesAppstore,
              height: size.height * .07,
              width: size.width * .7,
            ),
            const SizedBox(height: 14.0),
            Text(
              'Requires access to your $permission to perform this action.',
              style: GoogleFonts.montserrat(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            if (extraMessage.isValid)
              Text(
                extraMessage!,
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 14.0),
            Row(
              children: [
                if (Platform.isAndroid)
                  Expanded(
                    child: CustomButton(
                      elevation: 0,
                      type: ButtonType.secondary,
                      // color: Colors.white,
                      onTap: () => Navigator.pop(context, false),
                      title: 'Reject',
                    ),
                  ),
                if (Platform.isAndroid) const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    elevation: 0,
                    type: ButtonType.primary,
                    // color: Colors.black,
                    onTap: () => Navigator.pop(context, true),
                    title: 'Continue',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
