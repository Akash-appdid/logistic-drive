import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logistic_driver/services/route_helper.dart';
import 'package:logistic_driver/views/screens/pakers_and_movers/pakers_and_movers_screen.dart';

import '../../../../generated/assets.dart';
import '../../../../services/theme.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 60,
    leading: GestureDetector(
      onTap: () {
        log('test');
        Navigator.of(context).push(getCustomRoute(child: const PakersAndMoversScreen()));
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
    ),
    centerTitle: true,
    title: Container(
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
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
          ),
          Transform.scale(
            scale: .8,
            child: CupertinoSwitch(
              activeColor: buttonGreen,
              value: true,
              onChanged: (val) {},
            ),
          ),
        ],
      ),
    ),
    actions: [
      Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.svgsNotitfication,
          ),
        ),
      ),
      const SizedBox(width: 10)
    ],
  );
}
