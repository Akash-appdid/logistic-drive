import 'package:flutter/material.dart';

import '../../../../services/theme.dart';
import '../../dashboard/components/location_contaner_widget.dart';

class BookingItemWidget extends StatelessWidget {
  const BookingItemWidget({
    super.key,
    this.isComplete = false,
  });
  final bool isComplete;

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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Delivery Date: 25 March 2025',
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
                    isComplete ? 'Completed' : 'On Time',
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
