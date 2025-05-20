import 'package:flutter/material.dart';

import '../../../../../data/models/response/user_model.dart';
import '../../../../base/common_button.dart';
import 'title_and_value.dart';
import 'view_image_dialog.dart';

class BankInfoWidget extends StatelessWidget {
  const BankInfoWidget({
    super.key,
    this.userModel,
  });
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          TitleAndValue(
            title: 'Payee name: ',
            val: userModel?.payeeName ?? 'NA',
          ),
          Divider(color: Colors.grey.shade200),
          TitleAndValue(
            title: "Account number: ",
            val: userModel?.accountNumber ?? 'NA',
          ),
          Divider(color: Colors.grey.shade200),
          TitleAndValue(
            title: "IFSC code: ",
            val: userModel?.ifscCode ?? 'NA',
          ),
          Divider(color: Colors.grey.shade200),
          TitleAndValue(
            title: "Bank name: ",
            val: userModel?.bankName ?? 'NA',
          ),
          Divider(color: Colors.grey.shade200),
          TitleAndValue(
            title: "Bank branch: ",
            val: userModel?.bankBranch ?? 'NA',
          ),
          if (userModel?.cancelCheck != null)
            Divider(color: Colors.grey.shade200),
          if (userModel?.cancelCheck != null)
            Row(
              children: [
                const Expanded(
                  child: TitleAndValue(
                    title: 'Canceled check',
                    val: '',
                  ),
                ),
                CustomButton(
                  height: 30,
                  elevation: 0,
                  onTap: () {
                    if (userModel?.cancelCheck == null) return;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ViewImageDialog(
                          title: 'Canceled check',
                          image: userModel?.cancelCheck ?? '',
                        );
                      },
                    );
                  },
                  child: Text(
                    'View',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
        ],
      ),
    );
  }
}
