import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';

class CustomNoDataFoundWidget extends StatelessWidget {
  const CustomNoDataFoundWidget({
    super.key,
    this.assets = Assets.lottiesNoDataFound,
    this.text = 'No Data Found!',
  });
  final String assets;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          assets,
          height: 250,
          width: 250,
          fit: BoxFit.fill,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
