import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic_driver/services/route_helper.dart';

import 'package:logistic_driver/services/theme.dart';
import 'package:logistic_driver/views/base/common_button.dart';
import 'package:logistic_driver/views/base/custom_image.dart';
import 'package:logistic_driver/views/screens/pakers_and_movers/pakers_and_movers_pickup_location_screen/pakers_and_movers_pickup_location_screen.dart';

import '../../dashboard/components/location_contaner_widget.dart';
import '../home_items_list/home_item_list_screen.dart';
import 'components/sub_title_widget.dart';
import 'components/title_widget.dart';

class PakersAndMoversBookingDetailScreen extends StatelessWidget {
  const PakersAndMoversBookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //--------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF0F8000),
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        Assets.svgsTruck,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'On-Time',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                ],
              ),
            ),
            //-------------------
            Container(
              color: const Color(0xFFF5F5F5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  const CustomImage(
                    path: Assets.imagesTruck,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  //
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tata Ace',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff787878),
                            ),
                      ),
                      Text(
                        'MH 07 HG 2145',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff252525),
                            ),
                      )
                    ],
                  )
                ],
              ),
            ),
            //--------------------
            Padding(
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
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              color: const Color(0xFF0F8000),
              onTap: () {
                Navigator.of(context).push(getCustomRoute(child: const PakersAndMoversPickupLocationScreen()));
              },
              title: 'Pick up Location',
            ),
          )
        ],
      ),
    );
  }
}
