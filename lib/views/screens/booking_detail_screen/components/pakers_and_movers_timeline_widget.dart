import 'package:flutter/material.dart';

import '../../../../services/route_helper.dart';
import '../../../base/custom_image.dart';
import '../../dashboard/components/location_contaner_widget.dart';
import '../../home_items_list/home_item_list_screen.dart';

class PakersAndMoversTimeLineWidget extends StatelessWidget {
  const PakersAndMoversTimeLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocationContanerWidget(
                    iconColor: Color(0xff00C060),
                    icon: Icons.location_on,
                    label: "From",
                    name: "Kunal Pawar",
                    phone: "+91 89455 53123",
                    address: "Gopi Tank Marg, Mahim West, Shivaji Park...",
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const LocationContanerWidget(
                      iconColor: Color(0xffEB0404),
                      icon: Icons.location_on,
                      label: "To",
                      name: "Manoj Dalavi",
                      phone: "+91 89455 53123",
                      address: "Worli Shivaji Nagar, Worli Mumbai, Maharashtra 400030",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomImage(path: Assets.imagesMap),
                ],
              ),
            ),
          ),
          //---
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(getCustomRoute(child: const HomeItemListScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF11ABD5),
                    Color(0xFF09596F),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Home Items',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
