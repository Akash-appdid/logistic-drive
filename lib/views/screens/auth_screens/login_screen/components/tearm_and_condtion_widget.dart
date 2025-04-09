import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/auth_controller.dart';
import '../../../../../services/theme.dart';

class TearmAndCondtionWidget extends StatelessWidget {
  const TearmAndCondtionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<AuthController>(builder: (auth) {
          return Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(
                width: 1.0,
                color: auth.acceptTermAndCondition ? primaryColor : Colors.grey,
              ),
            ),
            activeColor: auth.acceptTermAndCondition ? primaryColor : null,
            value: auth.acceptTermAndCondition,
            onChanged: (val) {
              if (val != null) {
                auth.updateAcceptTermAndCondition(val);
              }
            },
          );
        }),
        //
        Expanded(
          child: RichText(
            text: TextSpan(
              text:
                  'By tapping next you\'re creating an account and you agree to the ',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.normal),
              children: [
                TextSpan(
                  text: 'Terms & conditons',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff09596F),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xff09596F),
                      ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: ' and acknowledge ',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                TextSpan(
                  text: 'Privacy policy',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff09596F),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xff09596F),
                      ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
