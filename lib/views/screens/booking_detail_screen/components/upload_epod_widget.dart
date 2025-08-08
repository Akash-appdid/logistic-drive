import 'dart:async';
import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../controllers/booking_controller.dart';
import '../../../../services/route_helper.dart';
import '../../../../services/theme.dart';
import '../../../base/common_button.dart';
import '../../../base/custom_image.dart';
import '../../../base/image_picker_sheet.dart';
import '../../auth_screens/signup_screen/components/components/certificate_image.dart';

class UploadEpodWidget extends StatelessWidget {
  const UploadEpodWidget({
    super.key,
    required this.bookingId,
  });

  final int bookingId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(initState: (_) {
      Timer.run(() {
        final controller = Get.find<BookingController>();
        controller.removeFiles();
      });
    }, builder: (controller) {
      if (controller.bookingsDetailData?.bookingType == 'goods' &&
          controller.bookingsDetailData?.status == 'delivered') {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.bookingsDetailData?.epod != null
                    ? 'Uploaded EPOD'
                    : "Upload EPOD :",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              Builder(builder: (_) {
                if (controller.bookingsDetailData?.epod != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: CustomImage(
                        width: double.infinity,
                        height: 250,
                        path: controller.bookingsDetailData?.epod ?? '',
                        fit: BoxFit.contain,
                        viewFullScreen: true,
                      ),
                    ),
                  );
                }
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (controller.ePodFile != null) {
                          Navigator.of(context).push(
                            getCustomRoute(
                              child: ShowImage(img: controller.ePodFile!),
                            ),
                          );
                          return;
                        }
                        await getImageBottomSheet(context).then((value) {
                          if (value != null) {
                            controller.selectFiles(val: value);
                          }
                        });
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xFFF2F2F2), width: 1),
                        ),
                        child: controller.ePodFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  controller.ePodFile!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: DottedBorder(
                                    color: primaryColor,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .2,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red.withValues(alpha: .1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            Assets.svgsImageSvg,
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.contain,
                                            colorFilter: const ColorFilter.mode(
                                              Colors.red,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Upload EPOD",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "jpeg , png or jpg formats",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    if (controller.ePodFile != null)
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
                                      controller.selectFiles(val: value);
                                    }
                                  });
                                },
                                icon: const IconsWidget(
                                  icon: Icons.edit,
                                )),
                            if (controller.ePodFile != null)
                              IconButton(
                                onPressed: () {
                                  controller.removeFiles();
                                },
                                icon: const IconsWidget(
                                  icon: Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                          ],
                        ),
                      ),
                  ],
                );
              }),
              const SizedBox(height: 10),
              Builder(builder: (_) {
                if (controller.bookingsDetailData?.epod != null) {
                  return const SizedBox.shrink();
                }
                return CustomButton(
                  isLoading: controller.isUploading,
                  onTap: controller.ePodFile == null
                      ? null
                      : () async {
                          Map<String, dynamic> data = {
                            'booking_id': bookingId,
                            'epod': getMultipartFile(controller.ePodFile),
                          };
                          log("$data");
                          await controller
                              .uploadEpod(data: data)
                              .then((val) async {
                            if (val.isSuccess) {
                              await controller.getBookingDetail(
                                id: bookingId,
                              );
                              controller.removeFiles();
                            } else {
                              Fluttertoast.showToast(msg: val.message);
                            }
                          });
                        },
                  title: 'Upload',
                );
              })
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
