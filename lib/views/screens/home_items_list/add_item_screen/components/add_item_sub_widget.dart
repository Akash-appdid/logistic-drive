import 'package:flutter/material.dart';

import '../../../../../data/models/response/home_item_model.dart';
import 'add_sub_item_widget.dart';

class AddItemSubWidget extends StatefulWidget {
  const AddItemSubWidget({
    super.key,
    required this.homeItem,
  });
  final List<HomeItem> homeItem;

  @override
  State<AddItemSubWidget> createState() => _AddItemSubWidgetState();
}

class _AddItemSubWidgetState extends State<AddItemSubWidget> {
  bool isExpand = true;
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
                      widget.homeItem.first.homeItemCategory?.title ?? 'NA',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Icon(
                      !isExpand
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up_outlined,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isExpand)
          Container(
            color: const Color(0xFFF2F2F2).withOpacity(0.6),
            child: ListView.builder(
              itemCount: widget.homeItem.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = widget.homeItem[index];
                return AddSubitemWidget(item: item);
              },
            ),
          )
      ],
    );
  }
}
