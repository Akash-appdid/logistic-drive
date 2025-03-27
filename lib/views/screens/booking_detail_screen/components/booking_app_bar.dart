import 'package:flutter/material.dart';

import '../../../../services/theme.dart';

AppBar bookingAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      'ID #23263513614',
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
    ),
    actions: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Text(
              'Support',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.headphones,
              size: 17,
            ),
          ],
        ),
      ),
      const SizedBox(width: 10),
    ],
  );
}
