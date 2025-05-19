import 'package:flutter/material.dart';

import '../../../../../data/models/response/user_model.dart';
import 'title_and_value.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({
    super.key,
    this.userModel,
  });
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          TitleAndValue(
            title: 'Name : ',
            val: userModel?.name ?? 'NA',
          ),
          Divider(color: Colors.grey.shade200),
          TitleAndValue(
            title: 'Mobile No : ',
            val: "+91 ${userModel?.phone}",
          ),
          if (userModel?.email != null)
            Column(
              children: [
                Divider(color: Colors.grey.shade200),
                TitleAndValue(
                  title: "Email ID : ",
                  val: userModel?.email ?? 'NA',
                ),
              ],
            ),
        ],
      ),
    );
  }
}
