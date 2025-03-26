import 'package:flutter/material.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/sub_title_widget.dart';
import 'package:logistic_driver/views/screens/booking_detail_screen/components/title_widget.dart';

import '../../../../generated/assets.dart';
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: const Color(0xffF6F6F6),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Est.Delivery Date',
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 15,
                                    color: const Color(0xFF8A8A8A),
                                  ),
                            ),
                            Text(
                              '25 Feb 2015',
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        color: const Color(0xffF6F6F6),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Distance',
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 15,
                                    color: const Color(0xFF8A8A8A),
                                  ),
                            ),
                            Text(
                              '25 KM',
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //----------------
                const SizedBox(height: 10),
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
                //--------------
                ,
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Your Earnings',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(
                            title: 'Total Fare',
                            val: '₹ 45000.00',
                          ),
                          SubTitleWidget(
                            subTitle: 'Trip Rate',
                            val: '₹ 45000',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(
                            title: 'Payment Received',
                            val: '₹ 15000.00',
                          ),
                          SubTitleWidget(
                            subTitle: 'Bank transfer',
                            val: '₹ 15000',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(
                            title: 'Remaining Balance Received',
                            val: '₹ 30000.00',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //-----------
        ],
      ),
    );
  }
}
