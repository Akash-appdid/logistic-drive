import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import '../../../../generated/assets.dart';
import '../../../../services/theme.dart';

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
                  controller.setIsDutyOn(val);
                  controller.toggleDutyOnOff().then((value) => {
                        if (value.isSuccess)
                          {
                            Get.find<AuthController>().getUserProfileData(),
                          }
                      });
                },
              ),
            ),
          ],
        ),
      );
    }),
  );
}
