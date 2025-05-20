import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/views/screens/auth_screens/signup_screen/components/components/certificate_image.dart';

import '../../../../base/common_button.dart';
import '../../../../base/custom_image.dart';
import 'title_and_value.dart';

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
                        'Aadhaar card no : ${authCtrl.userModel?.aadharCardNumber}',
                    val: '',
                  ),
                ),
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

class ViewImageDialog extends StatelessWidget {
  const ViewImageDialog({
    super.key,
    required this.image,
    this.imageTwo,
    required this.title,
  });
  final String image;
  final String title;
  final String? imageTwo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(getCustomRoute(
                    child: ShowImage(
                  image: image,
                )));
              },
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFF2F2F2), width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CustomImage(
                    path: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (imageTwo != null)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(getCustomRoute(
                      child: ShowImage(
                    image: imageTwo,
                  )));
                },
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: const Color(0xFFF2F2F2), width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CustomImage(
                      path: imageTwo ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
