import 'package:flutter/material.dart';

import 'home_edit_sub_sub_item_widget.dart';

class HomeEditSubItemWidget extends StatefulWidget {
  const HomeEditSubItemWidget({
    super.key,
  });

  @override
  State<HomeEditSubItemWidget> createState() => _HomeEditSubItemWidgetState();
}

class _HomeEditSubItemWidgetState extends State<HomeEditSubItemWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            isExpand = !isExpand;
            setState(() {});
          },
          child: SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chair',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Icon(
                      !isExpand ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_outlined,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isExpand)
          Container(
            color: const Color(0xFFF2F2F2),
            child: ListView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const HomeEditSubSubItemWidget();
              },
            ),
          )
      ],
    );
  }
}
