import 'package:flutter/material.dart';

import '../../../../../data/models/response/user_model.dart';
import '../../../../../services/extra_methods.dart';
import '../../../../base/common_button.dart';
import 'documents_widget.dart';
import 'title_and_value.dart';

class VehicleInfoWidget extends StatelessWidget {
  const VehicleInfoWidget({
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
            title: 'Vehicle: ',
            val: formatSentence(userModel?.vehicleType ?? 'NA'),
          ),
          Divider(color: Colors.grey.shade200),
          TitleAndValue(
            title: "Vehicle No: ",
            val: userModel?.vehicleNumber ?? 'NA',
          ),
          Divider(color: Colors.grey.shade200),
          if (userModel?.registrationCertificate != null)
            Row(
              children: [
                const Expanded(
                  child: TitleAndValue(
                    title: 'Registration certificate',
                    val: '',
                  ),
                ),
                CustomButton(
                  height: 30,
                  elevation: 0,
                  onTap: () {
                    if (userModel?.registrationCertificate == null) return;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ViewImageDialog(
                          title: 'Registration certificate',
                          image: userModel?.registrationCertificate ?? '',
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
