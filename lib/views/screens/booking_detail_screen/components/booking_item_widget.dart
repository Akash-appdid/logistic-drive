import 'package:flutter/material.dart';
import 'package:logistic_driver/data/models/response/booking_model.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/services/extra_methods.dart';

import '../../../../services/theme.dart';
import '../../dashboard/components/location_contaner_widget.dart';

class BookingItemWidget extends StatelessWidget {
  const BookingItemWidget({
    super.key,
    this.isComplete = false,
    required this.bookings,
  });
  final bool isComplete;
  final BookingsModel bookings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'ID #${(bookings.bookingId ?? '').toUpperCase()}',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
              ),
              Text(
                (bookings.createdAt as DateTime).dMy,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade200),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bookings.locations?.length,
            itemBuilder: (context, index) {
              final data = bookings.locations?[index];
              return LocationContanerWidget(
                iconColor: (data?.getLocationType ?? false)
                    ? const Color(0xff00C060)
                    : const Color(0xffEB0404),
                icon: Icons.location_on,
                label: "From",
                name: (data?.getLocationType ?? false)
                    ? (bookings.pickupUserName ?? 'NA')
                    : (bookings.dropUserName ?? 'NA'),
                phone:
                    "+91 ${(data?.getLocationType ?? false) ? bookings.pickupUserPhone : bookings.dropUserPhone}",
                address: data?.getAddress ?? '',
              );
            },
          ),
          Divider(color: Colors.grey.shade200),
          Row(
            children: [
              if (bookings.placed != null)
                Expanded(
                  child: Text(
                    'Delivery Date: ${(bookings.placed as DateTime).dMy}',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 7,
                    backgroundColor: green,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formatSentence(bookings.deliveryStatus ?? 'NA'),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
