import 'package:flutter/material.dart';

import '../../../../../services/theme.dart';
import '../../../dashboard/components/location_contaner_widget.dart';

class BookingItemWidget extends StatelessWidget {
  const BookingItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ID #12351302111',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                  ),
                ),
                Text(
                  '20 March 2025  11:25 AM',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade200),
            const LocationContanerWidget(
              iconColor: Color(0xff00C060),
              icon: Icons.location_on,
              label: "From",
              name: "Kunal Pawar",
              phone: "+91 89455 53123",
              address: "Gopi Tank Marg, Mahim West, Shivaji Park...",
            ),
            const LocationContanerWidget(
              iconColor: Color(0xffEB0404),
              icon: Icons.location_on,
              label: "To",
              name: "Manoj Dalavi",
              phone: "+91 89455 53123",
              address: "Worli Shivaji Nagar, Worli Mumbai, Maharashtra 400030",
            ),
            Divider(color: Colors.grey.shade200),
            Text(
              'Delivery Date: 25 March 2025',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
