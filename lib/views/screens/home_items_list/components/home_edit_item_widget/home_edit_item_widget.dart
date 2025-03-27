import 'package:flutter/material.dart';

import '../../../../../services/theme.dart';
import '../../../../base/common_button.dart';
import 'components/home_edit_sub_item_widget.dart';

class HomeEditItemWidget extends StatelessWidget {
  const HomeEditItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Living Room',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const HomeEditSubItemWidget();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    color: Colors.red,
                    onTap: () {},
                    title: 'Cancel',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    color: primaryColor,
                    onTap: () {},
                    title: 'Save Changes',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
