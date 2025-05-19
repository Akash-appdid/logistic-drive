import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/local_bike_tempo_controller.dart';
import '../../../../services/extra_methods.dart';
import '../../../../services/theme.dart';

class CustomerInfoWidget extends StatelessWidget {
  const CustomerInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBikeTempoController>(builder: (localBikeCtrl) {
      final bookingDetail = localBikeCtrl.localBikeTempoBookingData;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Customer Info',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Divider(
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bookingDetail?.getCustomerName} | ${bookingDetail?.getCustomerMobileNo}',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Package Type: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            TextSpan(
                              text: '${bookingDetail?.getPakageType}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (bookingDetail?.delivered == null)
                  GestureDetector(
                    onTap: () {
                      if (bookingDetail?.getCustomerMobileNo == null) return;
                      ExtraMethods()
                          .makeCall(bookingDetail?.getCustomerMobileNo ?? '');
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 4)
          ],
        ),
      );
    });
  }
}
