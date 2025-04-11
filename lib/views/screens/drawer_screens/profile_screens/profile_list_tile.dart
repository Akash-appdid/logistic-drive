import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final String value;

  const ProfileListTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: RichText(
        text: TextSpan(text: "$title : ", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black), children: [
          TextSpan(
            text: " $value",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black38, fontSize: 14),
          )
        ]),
      ),
    );
  }
}
