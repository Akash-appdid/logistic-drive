import 'package:flutter/material.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../../../../../data/models/response/booking_model.dart';
import '../../../../../services/theme.dart';

class EditHomeAppbarWidget extends StatelessWidget {
  const EditHomeAppbarWidget({
    super.key,
    required this.homeItem,
  });

  final List<BookingGoodHomeItem>? homeItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            homeItem?.first.getHomeDatCategoryTitle.capitalizeFirstOfEach ??
                'NA',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
          )
        ],
      ),
    );
  }
}
