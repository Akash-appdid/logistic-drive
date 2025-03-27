import 'package:flutter/material.dart';

import '../../../../services/theme.dart';

class DeliveryDateAndDistanceWidget extends StatelessWidget {
  const DeliveryDateAndDistanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTitleAndValueWidget(
                  title: 'Est.Delivery Date',
                  value: '25 Feb 2015',
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: CustomTitleAndValueWidget(
                  title: 'Distance',
                  value: '25 KM',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTitleAndValueWidget extends StatelessWidget {
  const CustomTitleAndValueWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: backgroundDark.withOpacity(.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 15,
                  color: const Color(0xFF8A8A8A),
                ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
          ),
        ],
      ),
    );
  }
}
