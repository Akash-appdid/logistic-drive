import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../services/theme.dart';

class BookingDetailShimmerWidget extends StatelessWidget {
  const BookingDetailShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 20,
            width: double.infinity,
          ),
          Container(
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
                Container(
                  height: 20,
                  width: 180,
                  color: Colors.white,
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
                          Row(
                            children: [
                              Container(
                                height: 16,
                                width: 100,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Container(
                                height: 16,
                                width: 100,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                height: 16,
                                width: 100,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Container(
                                height: 16,
                                width: 100,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 4)
              ],
            ),
          ),
          //------timeline------
          Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 14),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                              if (!(index == 1))
                                SizedBox(
                                  height: 30,
                                  child: DottedBorder(
                                    strokeWidth: 2,
                                    dashPattern: const [5, 5],
                                    color: Colors.grey.shade600,
                                    customPath: (size) {
                                      return Path()
                                        ..moveTo(size.width / 2, 8)
                                        ..lineTo(size.width / 2, 50);
                                    },
                                    child: const SizedBox.shrink(),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 16,
                                  width: 180,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  height: 16,
                                  width: 280,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              //--------order status--------
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      height: 20,
                      width: 180,
                      color: Colors.white,
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
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 16,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 16,
                                    width: 180,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey.shade200),
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 16,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 16,
                                    width: 180,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4)
                  ],
                ),
              ),
              //------payment info
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      height: 20,
                      width: 160,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Divider(
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 120,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Container(
                          height: 16,
                          width: 100,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //---order status-----
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      height: 20,
                      width: 160,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Divider(
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 120,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Container(
                          height: 16,
                          width: 100,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
