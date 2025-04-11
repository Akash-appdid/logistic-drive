import 'package:flutter/material.dart';

class IconAndTitleWidget extends StatelessWidget {
  const IconAndTitleWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: Colors.grey.shade600,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: const Color(0xff626161), fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
