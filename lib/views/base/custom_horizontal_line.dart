import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CustomHorizontalDottendLine extends StatelessWidget {
  const CustomHorizontalDottendLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: Color(0xffD9D9D9),
    );
  }
}
