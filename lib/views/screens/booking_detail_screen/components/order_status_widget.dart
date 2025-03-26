import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/assets.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF0F8000),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
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
          ),
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
    );
  }
}
