import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/register_controller.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

import '../../../../../../services/route_helper.dart';
import '../../../../../base/image_picker_sheet.dart';

class CertificateImageWidget extends StatelessWidget {
  const CertificateImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Registration certificate',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ),
        GetBuilder<AuthController>(builder: (authCtrl) {
          if (authCtrl.userModel?.registrationCertificate != null) {
            return Container(
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
                  path: authCtrl.userModel?.aadharCardFront ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }

          return GetBuilder<RegisterController>(builder: (controller) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (controller.selectedRegistrationFile != null) {
                      Navigator.of(context).push(
                        getCustomRoute(
                          child: ShowImage(
                              img: controller.selectedRegistrationFile!),
                        ),
                      );
                      return;
                    }
                    await getImageBottomSheet(context).then((value) {
                      if (value != null) {
                        controller.selectFiles(
                            isCertificationOfRegistration: true, val: value);
                      }
                    });
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
                    child: controller.selectedRegistrationFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.selectedRegistrationFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                        Icons.add_photo_alternate_outlined)),
                                const SizedBox(height: 10),
                                Text(
                                  'Add Registration certificate',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                //
                if (controller.selectedRegistrationFile != null)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await getImageBottomSheet(context)
                                    .then((value) {
                                  if (value != null) {
                                    controller.selectFiles(
                                        isCertificationOfRegistration: true,
                                        val: value);
                                  }
                                });
                              },
                              icon: const IconsWidget(
                                icon: Icons.edit,
                              )),
                          if (controller.selectedRegistrationFile != null)
                            IconButton(
                              onPressed: () {
                                controller.removeFiles(
                                    isCertificationOfRegistration: true);
                              },
                              icon: const IconsWidget(
                                icon: Icons.delete,
                                color: Colors.red,
                              ),
                            )
                        ],
                      )),
              ],
            );
          });
        }),
      ],
    );
  }
}

class IconsWidget extends StatelessWidget {
  const IconsWidget({
    super.key,
    required this.icon,
    this.color,
  });
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Card(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: color,
          size: 16,
        ),
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, this.img, this.image});
  final File? img;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: image != null
                ? CustomImage(
                    path: image ?? '',
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    img ?? File(''),
                    fit: BoxFit.cover,
                  ),
          ),
        ));
  }
}
