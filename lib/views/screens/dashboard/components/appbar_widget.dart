import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import '../../../../generated/assets.dart';
import '../../../../services/theme.dart';
import '../../../base/common_button.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 60,
    leading: Builder(builder: (ctx) {
      return GestureDetector(
        onTap: () {
          Scaffold.of(ctx).openDrawer();
        },
        child: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: SvgPicture.asset(
              Assets.svgsMenu,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }),
    centerTitle: true,
    title: GetBuilder<BasicController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'On Duty',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: buttonGreen,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Transform.scale(
              scale: .7,
              child: CupertinoSwitch(
                activeColor: buttonGreen,
                value: controller.isDutyOn,
                onChanged: (val) {
                  if (controller.isDutyOn) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return ActiveInactiveVendorDialog(
                          isLoading: controller.isLoading,
                          onTap: () {
                            controller.setIsDutyOn(val);
                            controller.toggleDutyOnOff().then((value) => {
                                  if (value.isSuccess)
                                    {
                                      Get.find<AuthController>()
                                          .getUserProfileData(),
                                      Navigator.pop(context),
                                    }
                                  else
                                    {
                                      controller.setIsDutyOn(val),
                                    }
                                });
                          },
                        );
                      },
                    );
                  } else {
                    controller.setIsDutyOn(val);
                    controller.toggleDutyOnOff().then((value) => {
                          if (value.isSuccess)
                            {
                              Get.find<AuthController>().getUserProfileData(),
                            }
                        });
                  }
                },
              ),
            ),
          ],
        ),
      );
    }),
  );
}

class ActiveInactiveVendorDialog extends StatelessWidget {
  const ActiveInactiveVendorDialog(
      {super.key, this.onTap, required this.isLoading});
  final bool isLoading;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cancel,
              color: Colors.red,
              size: 70,
            ),
            const SizedBox(height: 10),
            Text(
              'Go Off Duty',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Are you sure you want to go off duty?',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                elevation: 0,
                radius: 6,
                type: ButtonType.secondary,
                title: 'No',
                height: 46,
                onTap: () {
                  Navigator.pop(context, false);
                },
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                elevation: 0,
                color: Colors.red,
                radius: 6,
                type: ButtonType.primary,
                title: 'Yes',
                height: 46,
                isLoading: isLoading,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
