import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    required this.val,
    this.font = 16,
  });
  final String title;
  final String val;
  final double font;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: font,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Text(
          val,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: font,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
