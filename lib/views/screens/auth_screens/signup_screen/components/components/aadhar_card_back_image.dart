import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/register_controller.dart';
import '../../../../../../services/route_helper.dart';
import '../../../../../base/image_picker_sheet.dart';
import 'certificate_image.dart';

class AadharCardBackImageWidget extends StatelessWidget {
  const AadharCardBackImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return GestureDetector(
        onTap: () async {
          if (controller.selectedAadhaarBackCard != null) return;
          await getImageBottomSheet(context).then((value) {
            if (value != null) {
              controller.selectFiles(isAadharBackCard: true, val: value);
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: Text(
            //     'Aadhaar card',
            //     style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.black87,
            //         ),
            //   ),
            // ),
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(0, 2),
                    //     blurRadius: 1,
                    //     color: Colors.black.withOpacity(0.2),
                    //   )
                    // ],
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFFF2F2F2), width: 1),
                  ),
                  child: controller.selectedAadhaarBackCard != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            controller.selectedAadhaarBackCard!,
                            fit: BoxFit.cover,
                          ),
                        )
                      // : userID != null &&
                      //         controller
                      //                 .clientModel?.drugLicenseCertificate !=
                      //             null
                      //     ? ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: CustomImage(
                      //           viewFullScreen: true,
                      //           path:
                      //               "${controller.clientModel?.drugLicenseCertificate}",
                      //           fit: BoxFit.cover,
                      //         ),
                      //       )
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
                                'Add Aadhaar card back image',
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
                //
                if (controller.selectedAadhaarBackCard != null)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await getImageBottomSheet(context)
                                    .then((value) {
                                  if (value != null) {
                                    controller.selectFiles(
                                        isAadharBackCard: true, val: value);
                                  }
                                });
                              },
                              icon: const IconsWidget(
                                icon: Icons.edit,
                              )),
                          //
                          if (controller.selectedAadhaarBackCard != null)
                            IconButton(
                              onPressed: () {
                                if (controller.selectedAadhaarBackCard !=
                                    null) {
                                  Navigator.of(context).push(
                                    getCustomRoute(
                                      child: ShowImage(
                                          img: controller
                                              .selectedAadhaarBackCard!),
                                    ),
                                  );
                                }
                              },
                              icon: const IconsWidget(
                                icon: Icons.remove_red_eye_rounded,
                              ),
                            ),
                          //
                          if (controller.selectedAadhaarBackCard != null)
                            IconButton(
                              onPressed: () {
                                controller.removeFiles(isAadharBackCard: true);
                              },
                              icon: const IconsWidget(
                                icon: Icons.delete,
                                color: Colors.red,
                              ),
                            )
                        ],
                      )),
              ],
            ),
          ],
        ),
      );
    });
  }
}
