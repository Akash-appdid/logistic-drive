import 'package:flutter/material.dart';
import 'package:logistic_driver/services/route_helper.dart';

import 'package:page_transition/page_transition.dart';

import '../../../../base/common_button.dart';
import '../home_edit_item_widget/home_edit_item_widget.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Living Room',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
            ),
            const Spacer(),
            CustomButton(
              radius: 2,
              height: 35,
              onTap: () {
                Navigator.of(context).push(
                  getCustomRoute(
                    child: const HomeEditItemWidget(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: Text(
                'Edit',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey.shade100),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Chair',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Text(
                    '~10 items',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
