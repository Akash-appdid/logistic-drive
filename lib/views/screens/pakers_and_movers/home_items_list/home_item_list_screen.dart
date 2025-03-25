import 'package:flutter/material.dart';

import 'components/home_item_widget/home_item_widget.dart';

class HomeItemListScreen extends StatelessWidget {
  const HomeItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Items List',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const HomeItemWidget();
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 9,
                  color: Color(0xFFF1F1F1),
                );
              },
            )
            //
          ],
        ),
      ),
    );
  }
}
