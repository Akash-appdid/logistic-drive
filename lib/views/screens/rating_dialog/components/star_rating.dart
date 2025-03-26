import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class StarRating extends StatefulWidget {
  const StarRating({super.key});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int selectedStars = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedStars = index + 1;
            });
            log('$selectedStars');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Image.asset(
              index < selectedStars ? Assets.imagesFillStar : Assets.imagesStar,
              width: 35,
              height: 35,
            ),
          ),
        );
      }),
    );
  }
}
