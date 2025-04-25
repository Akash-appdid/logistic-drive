import 'package:flutter/material.dart';

import '../../../../../data/models/response/user_model.dart';
import '../../../../../services/extra_methods.dart';
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
            title: 'Vehicle: ',
            val: formatSentence(userModel?.vehicleType ?? 'NA'),
          ),
          Divider(color: Colors.grey.shade200),
          TitleAndValue(
            title: "Vehicle No: ",
            val: userModel?.vehicleNumber ?? 'NA',
          ),
        ],
      ),
    );
  }
}
