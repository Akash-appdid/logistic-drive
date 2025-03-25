import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({
    super.key,
    required this.subTitle,
    required this.val,
  });
  final String subTitle;
  final String val;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          subTitle,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: const Color(0xFF868686),
              ),
        ),
        const Spacer(),
        Text(
          val,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: const Color(0xFF868686),
              ),
        ),
      ],
    );
  }
}
