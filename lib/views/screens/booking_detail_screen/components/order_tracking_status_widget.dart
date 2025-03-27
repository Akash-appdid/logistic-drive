import 'package:flutter/material.dart';

import '../../../../services/theme.dart';

class OrderTrackingStatusWidget extends StatelessWidget {
  const OrderTrackingStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Tracking  Status:',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: green,
                              radius: 12,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Pick up 1',
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '20 March 2025  11:45 AM',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Divider(color: Colors.grey.shade200)
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
