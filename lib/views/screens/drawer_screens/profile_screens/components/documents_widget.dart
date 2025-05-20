import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';

import '../../../../base/common_button.dart';
import 'title_and_value.dart';
import 'view_image_dialog.dart';

class DocumentsWidget extends StatelessWidget {
  const DocumentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authCtrl) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TitleAndValue(
                    title:
                        'Aadhaar card no : ${authCtrl.userModel?.aadharCardNumber ?? 'NA'}',
                    val: '',
                  ),
                ),
                if (authCtrl.userModel?.aadharCardFront != null)
                  CustomButton(
                    height: 30,
                    elevation: 0,
                    onTap: () {
                      if (authCtrl.userModel?.aadharCardFront == null) return;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ViewImageDialog(
                            title: 'Aadhaar Card',
                            image: authCtrl.userModel?.aadharCardFront ?? '',
                            imageTwo: authCtrl.userModel?.aadharCardBack ?? '',
                          );
                        },
                      );
                    },
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                const SizedBox(width: 10),
              ],
            ),
            Divider(color: Colors.grey.shade200),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TitleAndValue(
                        title:
                            'Pan card no : ${authCtrl.userModel?.panCardNumber ?? 'NA'}',
                        val: '',
                      ),
                    ],
                  ),
                ),
                if (authCtrl.userModel?.panCard != null)
                  CustomButton(
                    height: 30,
                    elevation: 0,
                    onTap: () {
                      if (authCtrl.userModel?.panCard == null) return;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ViewImageDialog(
                            title: 'Pan Card',
                            image: authCtrl.userModel?.drivingLicence ?? '',
                          );
                        },
                      );
                    },
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                const SizedBox(width: 10),
              ],
            ),
            Divider(color: Colors.grey.shade200),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TitleAndValue(
                        title:
                            'Driving licence no : ${authCtrl.userModel?.drivingLicenseNumber ?? 'NA'}',
                        val: '',
                      ),
                    ],
                  ),
                ),
                if (authCtrl.userModel?.drivingLicence != null)
                  CustomButton(
                    height: 30,
                    elevation: 0,
                    onTap: () {
                      if (authCtrl.userModel?.drivingLicence == null) return;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ViewImageDialog(
                            title: 'Driving Licence',
                            image: authCtrl.userModel?.drivingLicence ?? '',
                          );
                        },
                      );
                    },
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      );
    });
  }
}
