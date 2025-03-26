import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    required this.val,
  });
  final String title;
  final String val;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Text(
          val,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
